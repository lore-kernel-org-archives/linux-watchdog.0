Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Guenter Roeck <linux@roeck-us.net>, Pratyush Anand <panand@redhat.com>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, wim@iguana.be,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <57289594.3050801@codeaurora.org> <20160503132439.GC13045@dhcppc6.redhat.com>
 <5728ABE0.5040000@roeck-us.net> <20160503141717.GD13045@dhcppc6.redhat.com>
 <5728B9BF.8050501@roeck-us.net>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <5728BE1B.5010904@codeaurora.org>
Date: Tue, 3 May 2016 10:04:59 -0500
MIME-Version: 1.0
In-Reply-To: <5728B9BF.8050501@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck wrote:
>> Most likely it will not be corrupted. But, if ISR has been called it
>> means
>> something went wrong, and watchdog was not kicked for the time
>> programmed as
>> "timeout". So, probably we should be extra careful.
>>
> This logic would apply to _every_ watchdog driver implementing interrupts.
> Actually, it would apply to _all_ kernel code, and the logic could be used
> to introduce hyper-defensive programming all over the place, bloat the
> kernel
> and ultimately make it all but unusable. I do not believe in such
> programming
> in an operating system kernel.
>
> On top of that, the assumption that the kernel would be still sane enough
> to call the interrupt handler, but not sane enough to actually execute it,
> seems to be a bit far-fetched.

Agreed.  Pratyush, have you ever seen any watchdog register get 
corrupted, like you describe?  It just seems like you're imagining a 
problem that has never occurred.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
