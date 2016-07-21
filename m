Return-path: <eballetbo@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5790CD25.5030002@roeck-us.net>
References: <1469010678-23058-1-git-send-email-enric.balletbo@collabora.com>
 <579044B8.3080508@roeck-us.net> <CAFqH_52EajJV6BQzf=VqJZEVr=XZZgjRW7KfTdEehx=C8eDGoA@mail.gmail.com>
 <5790CD25.5030002@roeck-us.net>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 21 Jul 2016 15:40:45 +0200
Message-ID: <CAFqH_52=6r-1ATvpsVT9Hh8RPdPWoxhZRFJ1bCWio=GaqoCZCg@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: ziirave_wdt: Add support to upload the firmware.
To: Guenter Roeck <linux@roeck-us.net>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

2016-07-21 15:24 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
> On 07/21/2016 01:59 AM, Enric Balletbo Serra wrote:
>
> [ ... ]
>
>>>>
>>>> +static ssize_t ziirave_wdt_sysfs_store_firm(struct device *dev,
>>>> +                                           struct device_attribute
>>>> *attr,
>>>> +                                           const char *buf, size_t
>>>> count)
>>>> +{
>>>> +       struct i2c_client *client = to_i2c_client(dev->parent);
>>>> +       struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
>>>> +       const struct firmware *fw;
>>>> +       int err;
>>>> +
>>>
>>>
>>>
>>> What happens if this file is opened twice and written in parallel ?
>>> What if any
>>> other attribute is accessed while the firmware download is ongoing ?
>>>
>>
>> Good point. So you think I need to protect all with mutexes or there
>
>
> Yes, you have to protect any possible damaging parallel access with mutexes.
>
>> is another way? From a quick look on other drivers i didn't see this
>> kind of protection (something to look at in the future)
>>
>
> Really ? Can you point me to some examples ? This would be a bug.
>
> You'll have to fix the to get your patch accepted. Pointing to other
> examples with the same or a similar bug is not an argument.
>

Yeah I know, I didn't want to justify me, I didn't express well if
this was your impression, I just wanted to point that there are some
drivers in other subsystems that I think that have this problem, I
only did a quick look though (is some upstreaming work that I can add
to my TODO list)

Already fixed in next v3 :)


> Thanks,
> Guenter
>
