Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:43830 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbaKSTf7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Nov 2014 14:35:59 -0500
Received: by mail-vc0-f177.google.com with SMTP id ij19so643740vcb.8
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Nov 2014 11:35:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <546CEF0C.1090204@imgtec.com>
References: <1416312442-15688-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1416312442-15688-2-git-send-email-Naidu.Tellapati@imgtec.com>
	<CAL1qeaGgs0CrWdUV8kYVxbJ-=46+Xhx__pZy390iX0OXTF1bHw@mail.gmail.com>
	<546CEF0C.1090204@imgtec.com>
Date: Wed, 19 Nov 2014 11:35:58 -0800
Message-ID: <CAL1qeaFD735-BNC6r5fFMw=Ggnk22rCPp=Tc5iOjSwdJWscUMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
From: Andrew Bresticker <abrestic@chromium.org>
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	James Hartley <James.Hartley@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 19, 2014 at 11:27 AM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
>
>
> On 11/18/2014 08:12 PM, Andrew Bresticker wrote:
>> Naidu,
>>
>> On Tue, Nov 18, 2014 at 4:07 AM,  <Naidu.Tellapati@imgtec.com> wrote:
>>> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>>
>>> This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
>>>
>>> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
>>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>
>> checkpatch reports that there's trailing whitespace and that you're
>> using DOS line endings.  Please be sure to fix that with this and your
>> other patches.
>>
>
> Andrew,
>
> Saving this patch with mutt as mbox and running checkpatch on it,
> doesn't report any problems with it.
>
> Maybe it's your client?

Oops, yes, you're right - my gmail settings have gotten screwed up somehow...
