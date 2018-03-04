Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:41808 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeCDTpg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 4 Mar 2018 14:45:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180304191934.GA14207@amd>
References: <CAEo2pztutpwd0wvJWVmQ2XaT43nQ99StFbDMT7MQ5dkrMdkJvw@mail.gmail.com>
 <20180304191934.GA14207@amd>
From: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
        <torso.nafi@gmail.com>
Date: Sun, 4 Mar 2018 22:45:35 +0300
Message-ID: <CAEo2pztPD3BoC==+R2AiJ2D3cyBRWphErNTp-evSsFZueK1-Xg@mail.gmail.com>
Subject: Re: A case of watchdog+LED shared GPIO pin
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2018-03-04 22:19 GMT+03:00 Pavel Machek <pavel@ucw.cz>:
> Improving WDIOC_SETTIMEOUT is obvious solution. I'd go for that.

Question is, then, - how to do it in a backwards-compatible manner?
There is very likely to be some userspace software out there which
relies on the assumption of the currently used whole seconds semantics
being in effect.

Add a new millisecond argument? But how to detect its presence in the handler?

Introduce a new ioctl? But how to do it neatly and reasonably?

> But actually, controlling GPIO entirely from userspace should work
> well, too. User is not going to notice the jitter in miliseconds...

>From my experience, sometimes a heavy load on the CPU by other
processes may cause quite noticeable lags, and it's hard to make sure
that our other developers would nice up their processes to give the
LED blinker enough 'priority'. Also, that doesn't factor in the time
between the boot and the process startup, since in our configuration
the 'system' processes such as watchdog are run way earlier than the
'appliance' processes, however the former may be in a read-only
squashfs partition which is a pain to update. But I'd like to have it
up and running as soon as possible, so...
