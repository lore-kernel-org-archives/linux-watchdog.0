Return-Path: <SRS0=sdpy=XB=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5153C00307
	for <linux-watchdog@archiver.kernel.org>; Fri,  6 Sep 2019 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D45621928
	for <linux-watchdog@archiver.kernel.org>; Fri,  6 Sep 2019 20:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btK5FQnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfIFUyS (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:54:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55760 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbfIFUyR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Sep 2019 16:54:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so7789003wmg.5
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Sep 2019 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9iZd0ALlBtpvj30ArgRGZaBRGe1rTkTBEtd4b0i1Vc=;
        b=btK5FQnLBlm6g7F416aGcrBn6jKUVra0FTu/DzgotZjZZuNDjoag8X+yBz0OLsKp6g
         Dq0RNsj2G7PfChBamSp11AcXANSgZLr7jxrx9kU6qpb1k3bpucpdf1T1h3RS1T+vBWsX
         GgAM1IG11ZZgh7Jkt5RnbO/uixzBtCrnMFg6A5nLkUyLBfuGRt+PzpF9KYtRBx65nrSf
         NruggiKMgiaX+ZtQeHwrIhQi0SweCAzo45ox8Z0bHnv6tcIktZ4vX/le4+SmtgWxIDuV
         A8fhK0Tos5nt8AvqRRiWJcFnrJcw3avzHgC+mJmpgsq+jOxpZbmCgHCwGQtRKzX7Lvbk
         fLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9iZd0ALlBtpvj30ArgRGZaBRGe1rTkTBEtd4b0i1Vc=;
        b=h5uNbZ4mT6AABXX7bOhd9NMccxlehKz6mDwXrufqSst/VTsOo59HPMt8byv3ubyQCC
         e0spLbt1j3fyjYr3YTbgFM/MmqWEjfgWLqbfTaQiLofePaxno+ry9Q0RPw0/hGJnvVUL
         7JMTzZyXJ9lTdtwbAkJ1LPQXClVZPEjZVJOwx76r6dx4M0Ry5c/QAb6n4IAqPxqAEPwM
         Or4wE9feTKyJ5RwAiSAJMni8N4Oig8uNrxh8uaV4jBifjvrGl5B+/Ng8YRBZFODeudbr
         yhVsNfhbDbvnqNU8L/8dEVf4bdGEeKVg7jYEUz+iOvzqdbhpgfnLjM6Ux9Ku1JMDknMs
         7nQQ==
X-Gm-Message-State: APjAAAUwQKvzHtcmKVoa+kyhRIVGC3m1XwX5WObMHpGf2d7H7BWi+iBK
        faklWe5ZaudBbWXPneLprtqpAw==
X-Google-Smtp-Source: APXvYqyg2YEhEjYWydK83Ag5waDnG5m0XCWk7plAWFXr9llFtUEHf6PI9Pb+1bqi64S6ZcbbChrJKA==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr9335213wme.127.1567803255262;
        Fri, 06 Sep 2019 13:54:15 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id q5sm317416wmq.3.2019.09.06.13.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 13:54:14 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        linux@roeck-us.net, wim@linux-watchdog.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] qcom_wdt bark irq support
Date:   Fri,  6 Sep 2019 22:54:09 +0200
Message-Id: <20190906205411.31666-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Support pre-timeout when the bark irq is avaible.

This is the fifth version of the patchset addressing all the review
issues to date:

 v5:
    include linux/bits.h
    pretimeout only enables IRQs if value != 0
    remove unnecessary subtract operation
    add clarity to the conditional in the probe function
    revert the irq registration changes
        
 v4:
    remove unnecessary include and private variable
    provide macro for WDT EN register values
    use pretimeout as per its API intent
    handle EPROBE_DEFER on get_irq
    modify the irq registration as per pm8916_wdt
    
 v3
    remove unecessary variable from the driver's private storage
 
 v2:
     register the pre-timeout notifier.

With the second patch in the set, I took the oportunity to do some
cleanup in the same code base removing an unnecesary variable from the
driver's private storage.

Jorge Ramirez-Ortiz (2):
  watchdog: qcom: support pre-timeout when the bark irq is available
  watchdog: qcom: remove unnecessary variable from private storage

 drivers/watchdog/qcom-wdt.c | 85 +++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 13 deletions(-)

-- 
2.23.0

