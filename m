Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:48484 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab3BMKdM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 05:33:12 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so1069050obb.37
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 02:33:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130213094401.GB7867@spo001.leaseweb.com>
References: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
 <1357639455-21935-2-git-send-email-fabio.porcedda@gmail.com>
 <20130212230303.GA7867@spo001.leaseweb.com> <CAHkwnC_XdgHSo8Vkz5Ae=DQ48BBhLPVx_hXTzLTcw+xZJaEi5A@mail.gmail.com>
 <20130213094401.GB7867@spo001.leaseweb.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Wed, 13 Feb 2013 11:32:52 +0100
Message-ID: <CAHkwnC8rA9FZL2MK_qQ8yrvK-T3nxvRqxrDACeaV6v8VpMPkxQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] watchdog: core: dt: add support for the
 timeout-sec dt property
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 13, 2013 at 10:44 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Fabio,
>
>> > I must admit that the different iterations of this patch only made it better.
>> > I like the idea that you are proposing here (put the default timeout in the
>> > watchdog_device struct and use a helper function to set the timeout parameter
>> > value or the timeout-sec dt value). To be able to use other mechanism in the
>> > future also, I think it make more sense to pass the device instead of the
>> > device_node.
>>
>> If i understand correctly you want to use "struct platform_device"
>> instead of "struct device_node",
>> in the function watchdog_init_timeout?
>
> No struct device instead of struct device_node.
>
>> > I also detailed your documentation a bit more and incorporated above changes
>> > in an adjusted patch. Can you have a look at it and if OK for you I will put
>> > it in linux-watchdog-next as your v10 :-).
>>
>> That's good for sure :)
>
> Will add it to the linux-watchdog-next tree today.
>

In a few minutes I will send the v8 patch set.

Best regards
--
Fabio Porcedda

> Kind regards,
> Wim.
>
