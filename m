Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37421 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLORdp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 15 Dec 2018 12:33:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so8504232oth.4
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Dec 2018 09:33:44 -0800 (PST)
Subject: Re: [PATCH v3] watchdog: mtx-1: Convert to use GPIO descriptor
To: Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
References: <20181211120412.27773-1-linus.walleij@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <37ca0383-e94a-5460-0ad3-fd997ac540a8@gmail.com>
Date: Sat, 15 Dec 2018 09:33:41 -0800
MIME-Version: 1.0
In-Reply-To: <20181211120412.27773-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Le 12/11/18 à 4:04 AM, Linus Walleij a écrit :
> This converts the MTX-1 driver to grab a GPIO descriptor
> associated with the device instead of using a resource with
> a global GPIO number.
> 
> The board using this driver appears to be out-of-tree
> (OpenWRT), but the users can be easily augmented by adding a
> machine descriptor table before registering the device.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
