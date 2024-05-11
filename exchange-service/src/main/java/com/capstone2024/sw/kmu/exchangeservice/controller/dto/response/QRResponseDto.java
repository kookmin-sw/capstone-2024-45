package com.capstone2024.sw.kmu.exchangeservice.controller.dto.response;

import com.capstone2024.sw.kmu.exchangeservice.client.UserClientResponseDto;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Builder;
import lombok.Getter;

public class QRResponseDto {

    @Schema(description = "qr 생성 시 인증 정보")
    @Builder
    @Getter
    public static class QRCode {

        @Schema(description = "hash-based mac", example = "")
        @NotEmpty
        private String hmac;

        @Schema(description = "유저 정보", example = "<userId>:<accountId>:<createdAt>")
        @NotEmpty
        private String userInfo;

        public static QRCode from(String hmac, String userInfo){
            return QRCode.builder()
                    .hmac(hmac)
                    .userInfo(userInfo)
                    .build();
        }
    }

    @Schema(description = "")
    @Builder
    @Getter
    public static class ScannedData {

        @Schema(description = "송금 받을 사람의 계좌 Id", example = "00000000-0000-0000-000000000000")
        @NotEmpty
        private String receiverAccountId;

        @Schema(description = "송금 받을 사람의 닉네임", example = "김국민")
        @NotEmpty
        private String receiverNickname;

        @Schema(description = "송금 받을 사람의 프로필 이미지", example = "")
        @NotEmpty
        private String receiverProfileImg;

        @Schema(description = "송금 보낼 사람의 잔액", example = "500")
        @NotEmpty
        private int senderBalance;

        public static ScannedData from(String receiverAccountId, UserClientResponseDto.UserInfo userInfo, int senderBalance){
            return ScannedData.builder()
                    .receiverAccountId(receiverAccountId)
                    .receiverNickname(userInfo.getNickname())
                    .receiverProfileImg(userInfo.getProfile_img())
                    .senderBalance(senderBalance)
                    .build();
        }
    }


}
