Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108CEC433E0
	for <linux-watchdog@archiver.kernel.org>; Thu, 18 Mar 2021 10:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBA764F3B
	for <linux-watchdog@archiver.kernel.org>; Thu, 18 Mar 2021 10:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCRK2S (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 18 Mar 2021 06:28:18 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCRK2Q (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 18 Mar 2021 06:28:16 -0400
Received: from [192.168.1.155] ([77.4.36.33]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M26j1-1lOkcd0NRZ-002XsB; Thu, 18 Mar 2021 11:27:54 +0100
Subject: Re: [PATCH v2 2/4] leds: simatic-ipc-leds: add new driver for Siemens
 Industial PCs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20210315095710.7140-1-henning.schild@siemens.com>
 <20210315095710.7140-3-henning.schild@siemens.com>
 <CAHp75VcBdR8xqfWqKe+DwGAUYByVL7SBK0p7tHcKPs7m4Ay1iw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <e2c6bec5-1f8e-c69a-9219-5c0a9f63ba56@metux.net>
Date:   Thu, 18 Mar 2021 11:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcBdR8xqfWqKe+DwGAUYByVL7SBK0p7tHcKPs7m4Ay1iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ixcya2BAbf0QE2jlA5UzDIT03D9u3Hv2Dnuz9dznwiCPoIY9XFN
 pd6RH7axDScUyRXgbv58maBTYc64gK1mtn9u8gS7rBihynwysKXzhfbi2btFnK8bM8ylEL9
 wqlfv2UWYfkh9am83GkUUKnID5Ihw/9q3buCj/wo+3W0jZt06dz/J8t7oQZHdg25XCYk7df
 yNUnr9kt4THGdIKaKyHUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t8IjnDFihBE=:Be/311bZOEqcvFuRFwPBrK
 wO/ALvA59N7m4mSHi+02UcArQRA0CPvfewMYiXMsSkB3Bp+TFhQ27dyuWz/cBxHn3mgKWhbxi
 8HgKpEuSJHocffh6iz/rVfw9j01J6DutmUO1kmKj9HJM+WdOWFirsZjiglXfGAZ2SC6BejLv4
 iObnCuuLCOxEASZJ9x7C7qeZ5Tv24Zk59X/gFYIpRszVMPxysd5jJEXDpZfbQin9O+UkSSwji
 vXvDND6aQoIeKXPrZBkF/8kT/lKojpX217n5wfW/0G8HNiNjHVVgz8Nd1ohPPWT+c/8DpiFlw
 ktAWl6rxZmvmn8usui4FlzaH6NLGxrTf8peo79YE0bem7nbWlpOMIzQ9rzSVICEmstSggOvF+
 jELQYL9+3SnDAp8zgTOWFF1WM3BmwWde4ozDfWN+BeOaRMOu+0ho2pLa/svx0
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 15.03.21 11:48, Andy Shevchenko wrote:

Hi,

> I have a question, why we can't provide a GPIO driver which is already
> in the kernel and, with use of the patch series I sent, to convert
> this all magic to GPIO LEDs as it's done for all normal cases?

Do we alread have a generic led driver that for cases that just
set/clear bits in some mem/io location ? If not, that would be really
great to have.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
