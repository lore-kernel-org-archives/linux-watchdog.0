Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33080 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbbKRPLC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Nov 2015 10:11:02 -0500
Subject: Re: [PATCH v3 2/5] mfd: syscon: add a DT property to set value width
To: Lee Jones <lee.jones@linaro.org>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447700814-5391-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151117091946.GG17829@x1> <20151117172649.GA11035@roeck-us.net>
 <20151118082144.GB3534@x1>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564C94FF.10004@roeck-us.net>
Date: Wed, 18 Nov 2015 07:10:55 -0800
MIME-Version: 1.0
In-Reply-To: <20151118082144.GB3534@x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/18/2015 12:21 AM, Lee Jones wrote:
[ ... ]
>>> Or, for more clarity:
>>>
>>>    of_property_read_u32(np, "bus-width", &bus_width);
>>>    if (bus_width)
>>>
>>> If you choose this version (which I think is my preferred method, don't
>>> forget to initialise 'bus_width' to zero.
>>>
>> Ignoring an error and depending on bus_width==0 to determine if the property
>> was provided seems odd, especially since it would "hide" if the bus-width
>> property is set to 0. In the original code, this would be detected as error.
>
> I'm not sure what you mean.  If bus_width==0, then a problem has
> occurred and we will not use the value.  If bus_width!=0 then we can
> assume that it's been set and (as the comment describes) the value
> will be checked for errors in regmap_init_mmio().
>

Your proposed code does not distinguish a missing property from "bus-width = <0>;".
It will silently ignore this case.

Guenter

