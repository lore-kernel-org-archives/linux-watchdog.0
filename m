Return-path: <twp@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jun 2016 10:04:17 -0700
From: Thomas Pedersen <twp@codeaurora.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/3] qcom watchdog fixes
In-Reply-To: <57720BB6.6010209@roeck-us.net>
References: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
 <57720BB6.6010209@roeck-us.net>
Message-ID: <d5e6aef85ac3743a01b9dc190d3f5557@codeaurora.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,


On 2016-06-27 22:31, Guenter Roeck wrote:
> On 06/27/2016 04:26 PM, Thomas Pedersen wrote:
>> Some boards (eg. qcom IPQ8064 based) Need these changes to avoid a 
>> spurious
>> watchdog reset.
>> 
>> Matthew McClintock (3):
>>    watchdog: qcom: update device tree bindings
>>    watchdog: qcom: add option for standalone watchdog not in timer 
>> block
>>    watchdog: qcom: configure BARK time in addition to BITE time
>> 
>>   .../devicetree/bindings/watchdog/qcom-wdt.txt      |  5 +-
>>   drivers/watchdog/qcom-wdt.c                        | 78 
>> ++++++++++++++++------
>>   2 files changed, 59 insertions(+), 24 deletions(-)
>> 
> 
> General comment: If you don't plan to address the comments made to
> the previous submission, please at least let the reviewers know
> what you are doing and why. Also, a note indicating that this
> is a resend would be helpful for those who did not see the original
> series.

Thanks, checking for earlier submissions slipped my mind. I'll address 
your
comments in a v2.

-- 
thomas
