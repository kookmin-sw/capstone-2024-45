package com.capstone2024.sw.kmu.exchangeservice.service;

import com.capstone2024.sw.kmu.exchangeservice.domain.bankcore.AccountInfo;
import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.TransactionHistory;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.RemittanceResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.TransactionHistoryResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional("transactionHistoryTransactionManager")
@RequiredArgsConstructor
public class RemittanceService {

    private final BankCoreService bankCoreService;
    private final TransactionHistoryService transactionHistoryService;

    public TransactionHistoryResponseDto.RemittanceResult remit(RemittanceResponseDto.Remittance dto, String userId) {

        int amount = dto.getAmount();
        AccountInfo senderInfo = bankCoreService.getInfo(dto.getSenderAccountId());
        AccountInfo receiverInfo = bankCoreService.getInfo(dto.getReceiverAccountId());

        // 보내는 사람의 잔액 -
        bankCoreService.updateBalance(senderInfo, amount, "DECREASE");

        // 받는 사람의 잔액 +
        bankCoreService.updateBalance(receiverInfo, amount, "INCREASE");


        // 통합 거래내역 생성
        TransactionHistory response = transactionHistoryService.create(senderInfo, receiverInfo, amount, userId);

        return TransactionHistoryResponseDto.RemittanceResult.from(response);

    }


}
