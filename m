Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:37495 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbeIKMhf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 11 Sep 2018 08:37:35 -0400
Date: Tue, 11 Sep 2018 09:39:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jeremy Gebben <jgebben@sweptlaser.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: abx80x: add basic watchdog support
Message-ID: <20180911073922.GG2494@piout.net>
References: <20180910213654.26059-1-jgebben@sweptlaser.com>
 <20180910213654.26059-3-jgebben@sweptlaser.com>
 <20180910232019.GA8439@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910232019.GA8439@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/09/2018 16:20:19-0700, Guenter Roeck wrote:
> > +static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
> > +				unsigned int new_timeout)
> 
> I'll leave multi-line alignment issues to the driver maintainer.
> 

Indeed, I'd like those to be aligned on the parenthesis.

Thank you for your review.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
