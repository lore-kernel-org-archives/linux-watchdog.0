Return-path: <vivien.didelot@savoirfairelinux.com>
Date: Tue, 30 Jun 2015 01:21:38 -0400 (EDT)
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernel <kernel@savoirfairelinux.com>
Message-ID: <914331425.70999.1435641698085.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <558ECCA2.2070204@roeck-us.net>
References: <1434581940-15086-2-git-send-email-vivien.didelot@savoirfairelinux.com> <20150622165327.GA1189@roeck-us.net> <1645175105.110998.1435005823701.JavaMail.zimbra@savoirfairelinux.com> <558ECCA2.2070204@roeck-us.net>
Subject: Re: [v2,2/3] watchdog: max63xx: add GPIO support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On Jun 27, 2015, at 12:17 PM, Guenter Roeck linux@roeck-us.net wrote:

> On 06/22/2015 01:43 PM, Vivien Didelot wrote:
>> Hi Guenter,
>>
>> On Jun 22, 2015, at 12:53 PM, Guenter Roeck linux@roeck-us.net wrote:
>>> On Wed, Jun 17, 2015 at 06:58:59PM -0400, Vivien Didelot wrote:
>>>> Introduce a new struct max63xx_platform_data to support MAX63xx watchdog
>>>> chips connected via GPIO. A platform code can fill this structure with
>>>> GPIO numbers for WDI and WDSET pins to enable GPIO support in the code.
>>>>
>>>> The driver takes care of requesting and releasing the GPIOs.
>>>>
>>>> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
>>>
>>> would it be possible to use gpiod functions ?
>>
>> It might be, but I never played with it yet though. I'm using integer-based
>> GPIOs from a TCA6424 on an x86 platform (no Device Tree). Is it ok to keep
>> max63xx_gpio_{ping,set} for legacy GPIOs, and let someone add
>> max63xx_gpiod_{ping,set} if there is a need?
>>
> 
> Hi Vivien,
> 
> That would pretty much defeat the purpose. The gpiod API is supposed
> to replace the gpio API, not to augment it. Having both at the same time
> does not really make sense.
> 
> There is a mapping from integer based pins to name based pins; check out
> gpiod_add_lookup_table(). Essentially platform initialization code
> (in your case probably the code which instantiates the tca6424) would
> set up a pin lookup table, and then you would request pins using
> a name instead of a number. That would also solve the "is the pin
> valid" problem in patch 3/3 since you would have a string to identify
> the gpio pin.

Unless I'm missing something, it seems like it won't work in my case. Here's my
setup. I have 2 TCA6424 I2C I/O expanders, exposing 24 GPIOs each. They are
registered like this:

	static struct i2c_board_info i2c_devices[] = {
	    {
	        I2C_BOARD_INFO("tca6424", 0x22),
	        .platform_data = &tca6424_1_pdata, // base = 100
	    }, {
	        I2C_BOARD_INFO("tca6424", 0x23),
	        .platform_data = &tca6424_2_pdata, // base = 200
	    }
	};

Then the pca953x driver adds two gpio chips, both labeled with the device name,
i.e. "tca6424".

I have to pass pins 219 to 222 to the max63xx_platform_data. I can declare a
GPIO lookup table like this:

    static struct gpiod_lookup_table lookup_table = {
        .dev_id = "max6373_wdt",
        .table = {
            GPIOD_LOOKUP("tca6424", 19, "MAX6373 WDI", GPIO_ACTIVE_HIGH),
	    GPIOD_LOOKUP_IDX("tca6424", 20, "MAX6373 SET", 0, GPIO_ACTIVE_HIGH),
	    GPIOD_LOOKUP_IDX("tca6424", 21, "MAX6373 SET", 1, GPIO_ACTIVE_HIGH),
	    GPIOD_LOOKUP_IDX("tca6424", 22, "MAX6373 SET", 2, GPIO_ACTIVE_HIGH),
        }
    };

but from what I've seen, the gpio_chip lookup by name will always return the
first TCA6424 instance.

To me, it looks like the gpiod API doesn't support several GPIO chips with the
same name. Either this must be fixed, or I should find a way to give the 2 I/O
expanders different names (e.g. "tca6424.0" and "tca6424.1").

As struct gpiod_lookup are meant for platform code, would that be bad if they 
ignore the chip_label and care about a global GPIO number (i.e. base + hwnum)?

Do you have an idea for this setup?

Thanks,
-v
