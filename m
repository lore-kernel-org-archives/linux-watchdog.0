Return-path: <vivien.didelot@savoirfairelinux.com>
Date: Mon, 15 Jun 2015 19:29:30 -0400 (EDT)
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernel <kernel@savoirfairelinux.com>
Message-ID: <452754143.100967.1434410970055.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <557F4689.1050907@roeck-us.net>
References: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com> <557F4689.1050907@roeck-us.net>
Subject: Re: [RESEND PATCH 0/3] watchdog: MAX63xx cleanup and platform
 settings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Jun 15, 2015, at 5:41 PM, Guenter Roeck linux@roeck-us.net wrote:

> On 06/15/2015 12:58 PM, Vivien Didelot wrote:
>> The first version of this patchset from January, 29 [1] got no feedback
>> from the maintainer. 1/4 [2] was applied to watchdog-next on May, 30
>> though. A concern about constants removal was raised in the preliminary
>> 2/4 cleanup patch, the explanation has been added to the related commit
>> message.
>>
> 
> Hi Vivien,
> 
> For my part, adding a comment about removal of constants does not alleviate
> my concern about removing those constants. I just don't believe that removing
> constants is a good idea, no matter what the arguments for doing so might be.

Ok then, I'll minimize this cleanup patch and keep MAX6369_WDSET and
MAX6369_WDI as is.

Thanks,
-v
