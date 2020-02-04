Return-Path: <SRS0=sN88=3Y=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F1AC35247
	for <linux-watchdog@archiver.kernel.org>; Tue,  4 Feb 2020 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A01C21582
	for <linux-watchdog@archiver.kernel.org>; Tue,  4 Feb 2020 15:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRXhrdh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBDPVm (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:21:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36993 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgBDPVm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Feb 2020 10:21:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so23598494wru.4;
        Tue, 04 Feb 2020 07:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYd/QKfvl5lKpjb0P27O+LHksv33HQMEU50lHIKW7qc=;
        b=NRXhrdh5Rb97QAC85TQXRfLbha7BQp5PxRsH4sese3VbM9AkgzbaItOgm/MDbZLsj+
         UKuR4IgAtwG+1yy7TsZ67lAlfd2ODdlrPMcfRUGLuvrNZB05GR7cI3AakFuVomWzZ4xD
         NV/tgUfHgHKVqvEovTB70a8rTWssXfzAB7mgaNU1WCy0MbS0UFydBpgNqZAkifH+0qHR
         KhCmGfvVxg5r7Yu8cRVvQ3XCR655Xt0/wPaoP7A0Kb7o3kCqct1q3AC9lCT5dCc4l0XQ
         //ZOv5xL+S/I3fvI6XzVkVrbkEny42NQR77EmDoDHdyFQqmYFdPyEryHcLVHS1GTCfs9
         RJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYd/QKfvl5lKpjb0P27O+LHksv33HQMEU50lHIKW7qc=;
        b=OYr9sLGOjUeNB6Bd8+BbGhgntQQvAzpawxdNXXI5l7357bmvg7NR401JlnmSA/64zU
         iFBn8LP7W3xWL7eAKkjGqJp+MUT/zBiOJPzKB2kmlAuyCDzOmy04q6MbLRBAgVozHVf9
         n+gktyVzCYS6wVxllvqItGLddMgUZQCRQba8DbgHRhiWm/u5ueTzkqz2zz3uyjXr78zh
         29g40fIrReEM/w39RPA7qrkMGRnMnHJmU2FrsO6S4Gzneigkz0WOK9evEbw7eV3a91lv
         8yLOM879vIfFe5ZmXhNClFYMhm3CoPjkM/zHvB4+0Ld6lt0XSUD1OiMurCuGOA01qx7P
         izow==
X-Gm-Message-State: APjAAAX6IoAuoc7CKBrzONePs8uvgHpPvKFqaFXyvDrEgUHVoYRi6dp7
        PB5BR/uJqvflqT6OC5U0644=
X-Google-Smtp-Source: APXvYqzKp5ib9bjFyBvcOodNWyfCm3frsjRuCpkEVS86DeFPQsVS9Oh78tgaxHBk7beSKl4Y27QKig==
X-Received: by 2002:a05:6000:1012:: with SMTP id a18mr12703005wrx.113.1580829699732;
        Tue, 04 Feb 2020 07:21:39 -0800 (PST)
Received: from Ansuel-XPS.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id x10sm29902174wrv.60.2020.02.04.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 07:21:39 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation: watchdog: qcom-wdt: add new no-pretimeout option
Date:   Tue,  4 Feb 2020 16:21:03 +0100
Message-Id: <20200204152104.13278-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200204152104.13278-1-ansuelsmth@gmail.com>
References: <20200204152104.13278-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add description for new no-pretimeout function to force legacy
probe if any interrupt is defined.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
index 33081bd33637..01978bff74ee 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
@@ -14,6 +14,8 @@ Required properties :
 Optional properties :
 - timeout-sec : shall contain the default watchdog timeout in seconds,
                 if unset, the default timeout is 30 seconds
+- no-pretimeout : shall be set if the platform have some interrupts
+                  defined in the node but doesn't support pretimeout
 
 Example:
 	watchdog@208a038 {
-- 
2.24.0

