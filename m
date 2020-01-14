Return-Path: <SRS0=qnIA=3D=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B31C33C9E
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Jan 2020 20:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387A724670
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Jan 2020 20:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANUUJ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:20:09 -0500
Received: from stcim.de ([78.46.90.227]:46760 "EHLO stcim.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgANUUJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Jan 2020 15:20:09 -0500
X-Greylist: delayed 1172 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 15:20:08 EST
Received: from [2001:4dd7:c2a1:0:a288:b4ff:fee5:f5cc] (helo=porty)
        by stcim with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <contact@stefanchrist.eu>)
        id 1irSMc-0001mT-EC; Tue, 14 Jan 2020 21:00:34 +0100
Date:   Tue, 14 Jan 2020 21:00:34 +0100
From:   Stefan Lengfeld <contact@stefanchrist.eu>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     support.opensource@diasemi.com, linux@roeck-us.net,
        Adam.Thomson.Opensource@diasemi.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: da9062: make restart handler atomic safe
Message-ID: <20200114200034.nbk6vf77ucngfs6o@porty>
References: <20200113091521.5754-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113091521.5754-1-m.felsch@pengutronix.de>
X-PGP-Key: https://stefanchrist.eu/personal/Stefan_Lengfeld_0xE44A23B289092311.asc
User-Agent: NeoMutt/20180716
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Marco,

On Mon, Jan 13, 2020 at 10:15:21AM +0100, Marco Felsch wrote:
> The restart handler is executed during the shutdown phase which is
> atomic/irq-less. The i2c framework supports atomic transfers since
> commit 63b96983a5dd ("i2c: core: introduce callbacks for atomic
> transfers") but unfortunately the regmap framework doesn't support it
> yet. Hard coding the i2c stuff can be done without worries since the
> DA9062 is an i2c-only device.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Stefan Lengfeld <contact@stefanchrist.eu>

Thanks for picking up the patch and submitting it.

Kind regards,
    Stefan
