Return-Path: <SRS0=7cld=WM=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D8C3A59C
	for <linux-watchdog@archiver.kernel.org>; Fri, 16 Aug 2019 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B7F21726
	for <linux-watchdog@archiver.kernel.org>; Fri, 16 Aug 2019 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laK7fSDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfHPQD6 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:03:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40721 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfHPQD6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 16 Aug 2019 12:03:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so2628547pla.7;
        Fri, 16 Aug 2019 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GwGe81D2anB9mnM0YX892gY8U5CQnq5hIJv2VCFOwV4=;
        b=laK7fSDD4qkzN+zl86yItrHAB8NU8mXzryoe9aRGvoMMZlT0TxpGj1/Ha4P4gflWHA
         T99Qh9Pi4zx7Z0VZurGNIEsu74Zsjp9V9p/Fi9rz/9LDM9DoCNQtoWhDgUBnmAsYErIk
         e8pJeBfK8RmXHBAaDVFOxyPaOCVNfr1gPHaFwrnBScbTG3owz0zDyzXls3ghLKtqfiEE
         c5S9WehnKAuWOJ6MM90VVf63G7hpd3qP8MfGbYmHoNcO+ImWDT7IiNFF/W+PUctGEbir
         oXmAHYOyWkbDr8k2Uf7CfsCn7D6p/21Yq4QVbDbrBd+ZC4Okr5CbBa0aMCHd0xR8VEze
         WoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GwGe81D2anB9mnM0YX892gY8U5CQnq5hIJv2VCFOwV4=;
        b=GfTC6HYNerXihVlbZE3hF0wCas8DqeGj7hxuNXAAKTEZ2QPYc5u8NjYckzRt0UiYRT
         bi82EEfmcQdIyeR86zVu4xJC5RY4ulY5edUyGbzW4EawiQY1z5OFbaiJ7wTntQR2jkgB
         q59X6HQbQhGchEvZI92T04EDgSeHQW0GHAVLZX73uhE62FjNW5hLgek3U+ONNxM2zOOL
         OqR2nx0oLiuXLiymSEpkj2PnAfYBZqmi4vi6aNV0HUn7GSM4Cav1CMwNX2Zk4bmTAQQ8
         DTjzLuKrkHuwVkZLrN4TmTpXA2Kvgt01gvk4I63MEnSJaAtyANVAmvxYrEj0+j5OHg0I
         rhHQ==
X-Gm-Message-State: APjAAAXH4pRUlbf7bARnCR7SbyH71Z3XunBiI6FVn/mE1Y7u/pyKWOq7
        XoXF+C6SvLqVVB01UQn6lpAiTT1R
X-Google-Smtp-Source: APXvYqzpm5dy7HXa9JCQorRwUEZmNlywT5j/avC3GHFnPAF1jfRW7adr1QAbkIJ+PGD5tvnPcTjpRQ==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61mr10288124plb.238.1565971437722;
        Fri, 16 Aug 2019 09:03:57 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id m20sm7578607pff.79.2019.08.16.09.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 09:03:57 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 0/2] watchdog: aspeed: Add support for ast2600
Date:   Sat, 17 Aug 2019 01:33:45 +0930
Message-Id: <20190816160347.23393-1-joel@jms.id.au>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hello,

Here's a small patch series to enable the ast2600 watchdog.

Joel Stanley (1):
  dt-bindings: watchdog: Add ast2600 compatible

Ryan Chen (1):
  watchdog: aspeed: Add support for AST2600

 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 1 +
 drivers/watchdog/aspeed_wdt.c                             | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.23.0.rc1

