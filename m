Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210B6C433E0
	for <linux-watchdog@archiver.kernel.org>; Tue, 26 Jan 2021 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76BD207C8
	for <linux-watchdog@archiver.kernel.org>; Tue, 26 Jan 2021 15:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392811AbhAZPtX (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 26 Jan 2021 10:49:23 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:46799 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392618AbhAZPs4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Jan 2021 10:48:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611676114; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=AIGp3sOSpcvWiZSeRL/t8BvDsbq1gMaRV6JTPMxNUP4=; b=HnoQy3TBL56iSQmM9CDJOZooOWkZ6LR9o9xIzP4SM0pyFMdnRYtr8+CAFnlglRfnzUwjJEyD
 DaNioeeQ8KVOwYCqEv6l1OeC9TkFdHuvqqYECWMQ9lahW1ctQVDUnKTNGjYnpz5obeq0yoHB
 WP7hwZDHiujY+qFigk+s3o1HCEs=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyJmNTk5OSIsICJsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 601039ab72b7c29fd5db02d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Jan 2021 15:47:55
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DBBAC43467; Tue, 26 Jan 2021 15:47:55 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49718C433CA;
        Tue, 26 Jan 2021 15:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49718C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/4] arm64: dts: qcom: Add watchdog bark irq for  SC7180, SDM845, SM8150, SM8250
Date:   Tue, 26 Jan 2021 21:17:28 +0530
Message-Id: <cover.1611466260.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

This series adds pre-timeout notification support via bark
interrupt for SC7180, SDM845, SM8150, SM8250 SoCs.

Note: This has a functional dependency on [1] without which
the watchdog functionality would be broken.

[1] https://lore.kernel.org/patchwork/patch/1371266/

Sai Prakash Ranjan (4):
  arm64: dts: qcom: sc7180: Add watchdog bark interrupt
  arm64: dts: qcom: sdm845: Add watchdog bark interrupt
  arm64: dts: qcom: sm8150: Add watchdog bark interrupt
  arm64: dts: qcom: sm8250: Add watchdog bark interrupt

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 +
 4 files changed, 4 insertions(+)


base-commit: 76bb4dc36d0e6bd13c70536a77240f93a0260f7e
prerequisite-patch-id: 46f598da3a2dbddfefa72da5636438142a00babd
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

