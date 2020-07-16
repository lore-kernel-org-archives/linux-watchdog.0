Return-Path: <SRS0=ViF7=A3=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B68C433E5
	for <linux-watchdog@archiver.kernel.org>; Thu, 16 Jul 2020 09:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCE22074B
	for <linux-watchdog@archiver.kernel.org>; Thu, 16 Jul 2020 09:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGPJ00 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:26:26 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46827 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgGPJ00 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 16 Jul 2020 05:26:26 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id EBFBB1C000E;
        Thu, 16 Jul 2020 09:26:23 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Johnson CH Chen <JohnsonCH.Chen@moxa.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>
Subject: Re: [PATCH v4] rtc: rtc-ds1374: wdt: Use watchdog core for watchdog part
Date:   Thu, 16 Jul 2020 11:26:22 +0200
Message-Id: <159489140863.10170.12784684285559869041.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <HK2PR01MB328182D5A54BFAA8A22E448AFA640@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
References: <HK2PR01MB328182D5A54BFAA8A22E448AFA640@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, 9 Jul 2020 06:34:06 +0000, Johnson CH Chen (陳昭勳) wrote:
> Let ds1374 watchdog use watchdog core functions. It also includes
> improving watchdog timer setting and nowayout, and just uses ioctl()
> of watchdog core.

Applied, thanks!

[1/1] rtc: ds1374: wdt: Use watchdog core for watchdog part
      commit: d3de4beb14a887754b83843bf23b6dbe8d022764

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
