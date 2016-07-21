Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51629 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbcGUNZH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Jul 2016 09:25:07 -0400
Subject: Re: [PATCH v2] watchdog: ziirave_wdt: Add support to upload the
 firmware.
To: Enric Balletbo Serra <eballetbo@gmail.com>
References: <1469010678-23058-1-git-send-email-enric.balletbo@collabora.com>
 <579044B8.3080508@roeck-us.net>
 <CAFqH_52EajJV6BQzf=VqJZEVr=XZZgjRW7KfTdEehx=C8eDGoA@mail.gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5790CD25.5030002@roeck-us.net>
Date: Thu, 21 Jul 2016 06:24:53 -0700
MIME-Version: 1.0
In-Reply-To: <CAFqH_52EajJV6BQzf=VqJZEVr=XZZgjRW7KfTdEehx=C8eDGoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/21/2016 01:59 AM, Enric Balletbo Serra wrote:

[ ... ]

>>>
>>> +static ssize_t ziirave_wdt_sysfs_store_firm(struct device *dev,
>>> +                                           struct device_attribute *attr,
>>> +                                           const char *buf, size_t count)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(dev->parent);
>>> +       struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
>>> +       const struct firmware *fw;
>>> +       int err;
>>> +
>>
>>
>> What happens if this file is opened twice and written in parallel ?
>> What if any
>> other attribute is accessed while the firmware download is ongoing ?
>>
>
> Good point. So you think I need to protect all with mutexes or there

Yes, you have to protect any possible damaging parallel access with mutexes.

> is another way? From a quick look on other drivers i didn't see this
> kind of protection (something to look at in the future)
>

Really ? Can you point me to some examples ? This would be a bug.

You'll have to fix the to get your patch accepted. Pointing to other
examples with the same or a similar bug is not an argument.

Thanks,
Guenter

