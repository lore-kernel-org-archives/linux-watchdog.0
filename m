Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88265C433EF
	for <linux-watchdog@archiver.kernel.org>; Wed,  1 Jun 2022 10:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352326AbiFAKpv (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352265AbiFAKpn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Jun 2022 06:45:43 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF27E1DB;
        Wed,  1 Jun 2022 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654080343; x=1685616343;
  h=from:to:cc:subject:date:message-id;
  bh=rpi2VzHyXBf4aaeMCg1+hxYs73JeG6jNmWiysOqFD4s=;
  b=Fcxyt6p/neVsN912RIPaxtdqy/0CAtUZ++mOcyli9+pHTezW03LkEw94
   +anVg7424E0+ljy2+ex8bOkztQ0VK16BZIj5isNeDgcOjGRLmhciNciIS
   QD0HSKnbS5F3y8J7oY959JYW9BI2DW+qxTOloadC/vN1u7gSiI17tVvO+
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 03:45:43 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Jun 2022 03:45:41 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 01 Jun 2022 16:15:19 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id CD1F43F92; Wed,  1 Jun 2022 16:15:18 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 00/11] Devicetree Changes SDX65
Date:   Wed,  1 Jun 2022 16:15:01 +0530
Message-Id: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

This series adds cpufreq, watchdog dt nodes and enables 
remoteproc in sdx65 mtp.

Thanks,
Rohit.

Rohit Agarwal (11):
  ARM: dts: qcom: sdx65: Add CPUFreq support
  ARM: dts: qcom: sdx65: Add modem SMP2P node
  ARM: dts: qcom: sdx65: Add IMEM and PIL info region
  dt-bindings: firmware: scm: Add compatible for SDX65
  ARM: dts: qcom: sdx65: Add SCM node
  ARM: dts: qcom: sdx65: Add Modem remoteproc node
  ARM: dts: qcom: sdx65-mtp: Enable modem
  ARM: dts: qcom: sdx65-mtp: Increase the vmalloc size
  dt-bindings: watchdog: Add binding for Qcom SDX65
  ARM: dts: qcom: sdx65: Add Watchdog support
  ARM: dts: qcom: sdx65: Add pshold support

 .../devicetree/bindings/firmware/qcom,scm.txt      |   1 +
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   1 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               |   6 +
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 124 +++++++++++++++++++++
 4 files changed, 132 insertions(+)

-- 
2.7.4

