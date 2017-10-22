Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:54832 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdJVQWI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 12:22:08 -0400
Subject: Re: [PATCH v2 4/4] watchdog: aspeed: Move init to arch_initcall
To: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
References: <20170920053020.6860-1-andrew@aj.id.au>
 <20170920053020.6860-5-andrew@aj.id.au>
 <CACPK8Xdz1iK-4bqZfmfTUYw3zDLxCniwt6LupJq5mo-CCca3XQ@mail.gmail.com>
 <1508240158.24322.16.camel@aj.id.au>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c3f1b8d1-fe4d-c68f-5f05-c4cb75912e2c@roeck-us.net>
Date: Sun, 22 Oct 2017 09:22:05 -0700
MIME-Version: 1.0
In-Reply-To: <1508240158.24322.16.camel@aj.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/17/2017 04:35 AM, Andrew Jeffery wrote:
> On Wed, 2017-09-20 at 15:43 +0930, Joel Stanley wrote:
>>> On Wed, Sep 20, 2017 at 3:00 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
>>> Probing at device_initcall time lead to perverse cases where the
>>> watchdog was probed after, say, I2C devices, which then leaves a
>>> potentially running watchdog at the mercy of I2C device behaviour and
>>> bus conditions.
>>>
>>> Load the watchdog driver early to ensure that the kernel is patting it
>>> well before initialising peripherals.
>>>
>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>
>> I agree that we need to make sure the watchdog driver is loaded
>> earlier. I think this is the correct method, but I'll defer to Guenter
>> on this one.
> 
> Just following up on Joel's comments: Is there anything else I need to
> address?
> 

No. Sorry, I have been terribly busy. Digging through patch backlog today.

Guenter

