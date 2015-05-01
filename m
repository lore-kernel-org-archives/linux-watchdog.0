Return-path: <timur@codeaurora.org>
Message-ID: <5543CA15.2020204@codeaurora.org>
Date: Fri, 01 May 2015 13:46:45 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>,
 Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>,
 linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org> <5543B7D0.706@codeaurora.org> <20150501173209.GA7712@roeck-us.net> <5543BAE7.5040909@codeaurora.org> <20150501175923.GC7712@roeck-us.net>
In-Reply-To: <20150501175923.GC7712@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/01/2015 12:59 PM, Guenter Roeck wrote:
> You are saying that pretty much everyone in the kernel is, in your opinion,
> doing the Wrong Thing (tm) and you insist in doing it differently.

No, of course not, it's just that I've written code like this many 
times, and no one else ever complained about my error messages before.

> As maintainer, I have seen lots of patches which remove this very same error
> checking as unnecessary. If we accept your code, we can be all but sure to
> see such a patch at some point, probably right after your patch was accepted
> and shows up in linux-next. So besides arguing about something we should not
> have to argue about in the first place, you are trying to create even more
> maintainer work going forward.

Ok, ok!  I'll remove it.  I just trying to understand the rationale.  I 
don't agree with it, but I'll make the change you want.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
