Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38901 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965983AbcAZPaZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jan 2016 10:30:25 -0500
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: William Breathitt Gray <vilhelm.gray@gmail.com>, wim@iguana.be
References: <20160126143106.GA5539@sophia>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A7910E.2040808@roeck-us.net>
Date: Tue, 26 Jan 2016 07:30:22 -0800
MIME-Version: 1.0
In-Reply-To: <20160126143106.GA5539@sophia>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/26/2016 06:31 AM, William Breathitt Gray wrote:
> On 01/25/2016 5:11 PM, Guenter Roeck wrote:
>>> +		dev_warn(dev, "Invalid timeout (%u seconds), using default (%u seconds)\n",
>>> +			timeout, WATCHDOG_TIMEOUT);
>>
>> Multi-line alignment is off by one character.
>
> I used tabs to align the lines to 8-character boundaries. Should I add
> an additional space to align the "timeout" argument with the "dev"
> argument?
>

Continuation line alignment should be with "(", so, yes, on the same column as "dev".

Thanks,
Guenter

