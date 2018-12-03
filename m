Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeLCIMZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Dec 2018 03:12:25 -0500
Subject: Re: [PATCH] watchdog: mena21_wdt: Convert to GPIO descriptors
To: Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20181202110410.17562-1-linus.walleij@linaro.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <5bc6b938-3cd0-73e5-f3c0-5ae2be2761f4@suse.de>
Date: Mon, 3 Dec 2018 09:12:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181202110410.17562-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/12/2018 12:04, Linus Walleij wrote:
> This drops the old OF API use to look up global GPIO
> numbers and replace it with the GPIO descriptor API.
> 
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Johannes Thumshirn <morbidrsa@gmail.com>
> Cc: Johannes Thumshirn <jth@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

I guess I have to many E-Mail addresses...

Anyways,
Acked-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
