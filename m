Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:36146 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbaKST2y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Nov 2014 14:28:54 -0500
Message-ID: <546CEF0C.1090204@imgtec.com>
Date: Wed, 19 Nov 2014 16:27:08 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Andrew Bresticker <abrestic@chromium.org>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	James Hartley <James.Hartley@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: Re: [PATCH v3 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
References: <1416312442-15688-1-git-send-email-Naidu.Tellapati@imgtec.com>	<1416312442-15688-2-git-send-email-Naidu.Tellapati@imgtec.com> <CAL1qeaGgs0CrWdUV8kYVxbJ-=46+Xhx__pZy390iX0OXTF1bHw@mail.gmail.com>
In-Reply-To: <CAL1qeaGgs0CrWdUV8kYVxbJ-=46+Xhx__pZy390iX0OXTF1bHw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 11/18/2014 08:12 PM, Andrew Bresticker wrote:
> Naidu,
> 
> On Tue, Nov 18, 2014 at 4:07 AM,  <Naidu.Tellapati@imgtec.com> wrote:
>> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>
>> This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
>>
>> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> 
> checkpatch reports that there's trailing whitespace and that you're
> using DOS line endings.  Please be sure to fix that with this and your
> other patches.
> 

Andrew,

Saving this patch with mutt as mbox and running checkpatch on it,
doesn't report any problems with it.

Maybe it's your client?
-- 
Ezequiel
