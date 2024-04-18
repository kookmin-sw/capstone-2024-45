package com.capstone2024.sw.kmu.exchangeservice.controller;

import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.request.RemittanceRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.response.RemittanceResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.response.TransactionHistoryResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.service.RemittanceService;
import com.capstone2024.sw.kmu.exchangeservice.service.TransactionHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.ErrorResponse;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/exchange/")
public class RemittanceController {

    private final RemittanceService remittanceService;
    private final TransactionHistoryService transactionHistoryService;

    // 송금
    @Operation(summary = "자유 송금", description = "자유 송금을 합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "성공"),
            @ApiResponse(responseCode = "400", description = "요청 형식 혹은 요청 콘텐츠가 올바르지 않을 때,",content = @Content(schema = @Schema(implementation = ErrorResponse.class))),
            @ApiResponse(responseCode = "401", description = "비밀번호 인증 에러 또는 거래상태 비적합",content = @Content(schema = @Schema(implementation = ErrorResponse.class))),
            @ApiResponse(responseCode = "402", description = "금액 부족",content = @Content(schema = @Schema(implementation = ErrorResponse.class))),
            @ApiResponse(responseCode = "403", description = "block된 계좌", content = @Content(schema = @Schema(implementation = ErrorResponse.class))),
            @ApiResponse(responseCode = "500", description = "서버 에러", content = @Content(schema = @Schema(implementation = ErrorResponse.class)))
    })
    @PostMapping("/remittance/qr")
    public ResponseEntity<APIResponse<TransactionHistoryResponseDto.RemittanceResult>> QRRemittance(
            @Schema(description = "송금 요청", required = true)
            @RequestHeader String userId,
            @RequestBody RemittanceRequestDto.QRRemittance remit
    ) throws IllegalAccessException {
        RemittanceResponseDto.Remittance dto = RemittanceResponseDto.Remittance.converseFrom(remit);

        TransactionHistoryResponseDto.RemittanceResult response = remittanceService.remit(dto, userId);

        return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS, response));
    }

    // 송금
    @Operation(summary = "특정 계좌의 거래 내역 확인", description = "거래 내역을 확인합니다.")
    @PostMapping("/remittance/history")
    public ResponseEntity<APIResponse<List<TransactionHistoryResponseDto.RemittanceList>>> getHistory(
            @RequestBody RemittanceRequestDto.History dto  // TODO: userID 받아와서 user 검증?
    ) throws IllegalAccessException {

        return ResponseEntity.ok(transactionHistoryService.getUserHistory(dto)); // TODO: 다른 endpoint 도 이렇게 refactoring
    }
}
