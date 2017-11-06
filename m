Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway34.websitewelcome.com ([192.185.149.105]:47159 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750750AbdKFBHK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 5 Nov 2017 20:07:10 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id D7DEC62A0E
        for <linux-watchdog@vger.kernel.org>; Sun,  5 Nov 2017 18:43:56 -0600 (CST)
Date: Sun, 05 Nov 2017 18:43:55 -0600
Message-ID: <20171105184355.Horde.qPNDMxxpZkcqJti0wwBTBaV@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: wdt_pci: mark expected switch fall-through
References: <20171103230723.GA5105@embeddedor.com>
 <20171105151335.GA27113@roeck-us.net>
In-Reply-To: <20171105151335.GA27113@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Quoting Guenter Roeck <linux@roeck-us.net>:

> On Fri, Nov 03, 2017 at 06:07:23PM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that in this particular case I replaced "Fall" with a proper
>> "fall through" comment, which is what GCC is expecting to find.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Thanks!
--
Gustavo A. R. Silva





