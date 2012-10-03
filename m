Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50728 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab2JCQdO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Oct 2012 12:33:14 -0400
Received: by obbuo13 with SMTP id uo13so7480441obb.19
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Oct 2012 09:33:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121002195914.GG21046@lunn.ch>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
 <1349094281-28889-4-git-send-email-fabio.porcedda@gmail.com>
 <20121001124546.GE11837@lunn.ch> <CAHkwnC_u+bMX7REU5G3u=cm3VGmOUn+AShruw+ERkPJWtZpxUg@mail.gmail.com>
 <CAHkwnC_5wRgf-DGnUfzkrreT_E1v8i=G8U0qo_5t1DY6+L7c+w@mail.gmail.com>
 <20121001130658.GG11837@lunn.ch> <CAHkwnC83DcKXZOtLse_xnYe7zOZ5qwGJVimLkBzDwSJ7Y5vL_Q@mail.gmail.com>
 <20121002195914.GG21046@lunn.ch>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Wed, 3 Oct 2012 18:32:53 +0200
Message-ID: <CAHkwnC_RUQ+hhzHAVEK5u4UUJDArKQNjEdXTzswn6cfYPWU_ew@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] watchdog: at91sam9_wdt: add device tree support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 2, 2012 at 9:59 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> I was thinking to add a more generic helper function like this:
>>
>> static inline void watchdog_get_dttimeout(struct device_node *node,
>> u32 *timeout)
>> {
>>       if (node)
>>               of_property_read_u32(node, "timeout", &wdd->timeout);
>> }
>
> You forgot to change the function signature.
>
> Also, if you are adding a generic function, it should be a generic
> function for the framework. All drivers should be slowly moving
> towards the framework, so adding functions which help you not move
> towards the framework are wrong.

Maybe i can use a framework specific function and use a dummy
watchdog_device for
the non framerwork drivers.

If it's ok i will send an updated patch.

Best regards and thanks for the review.
-- 
Fabio Porcedda
