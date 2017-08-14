Return-Path: <michal.simek@xilinx.com>
Return-path: <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/2] watchdog: cadence_wdt: Enable access to module
 parameters
To: Guenter Roeck <linux@roeck-us.net>, Michal Simek <michal.simek@xilinx.com>
CC: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
 <20170814144727.GB14491@roeck-us.net>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <37041da3-51f2-95c4-1d98-c0732b6a5082@xilinx.com>
Date: Mon, 14 Aug 2017 16:51:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170814144727.GB14491@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 14.8.2017 16:47, Guenter Roeck wrote:
> On Fri, Aug 04, 2017 at 09:39:16AM +0200, Michal Simek wrote:
>> Give read access to module parameters to all and write access to root.
>> This change also improves driver error path testing.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
>> ---
>>
>> Please let me know what you think - I can use macros from stat.h if
>> required
>>
> You mean instead of 0644 ? That is discouraged nowadays.

yep and good.

Thanks,
Michal
