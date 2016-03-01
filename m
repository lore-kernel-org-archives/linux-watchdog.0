Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35596 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbcCAFMr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Mar 2016 00:12:47 -0500
Subject: Re: [PATCH 2/3] ipmi/watchdog: Use nmi_panic() when kernel panics in
 NMI handler
To: =?UTF-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>,
	"'minyard@acm.org'" <minyard@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015039.4318.58063.stgit@softrs> <56D4FEAE.7080909@acm.org>
 <04EAB7311EE43145B2D3536183D1A84454B06310@GSjpTKYDCembx31.service.hitachi.net>
Cc: "openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Michal Hocko <mhocko@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D524CC.40903@roeck-us.net>
Date: Mon, 29 Feb 2016 21:12:44 -0800
MIME-Version: 1.0
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454B06310@GSjpTKYDCembx31.service.hitachi.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/29/2016 08:23 PM, 河合英宏 / KAWAI，HIDEHIRO wrote:
> Hi Corey,
>
> Thanks for the review.
>
>> Sure, this is a good idea.
>>
>> Acked-by: Corey Minyard <cminyard@mvista.com>
>>
>> Note that nmi_panic() came in commit 1717f2096b5 (panic, x86: Fix
>> re-entrance problem due to panic on NMI) and then the regs field
>> was added in the commit you reference.
>
> Yes. So, I'll change the description to more proper one.
>
>> Do you want me to add this to the IPMI queue or do you have another
>> way to get this patch into the kernel?
>
> I don't have another way, and I don't know how cross-subsystem
> patch set should be handled.
>
> I think it would be better this patch set is managed by one person
> because both PATCH 2/3 and 3/3 depend on 1/3.
>

We'll need an Ack from someone with authority over kernel/panic.c.
If someone sends an Ack, the series can go through IPMI (or watchdog).
It might be easier though if Andrew would take the entire series.

Guenter

