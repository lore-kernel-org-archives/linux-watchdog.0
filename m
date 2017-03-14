Return-path: <krzk@kernel.org>
MIME-Version: 1.0
In-Reply-To: <2568764.DQnxL2m83S@amdc3058>
References: <20170313190726.2988-1-krzk@kernel.org> <CGME20170314131709epcas5p4e150e0df2a04a3369edf61b2075e2e8f@epcas5p4.samsung.com>
 <20170313190726.2988-3-krzk@kernel.org> <2568764.DQnxL2m83S@amdc3058>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 14 Mar 2017 15:20:48 +0200
Message-ID: <CAJKOXPeoHVECsyT+Jy4D3bCwed2gsiKq3akMcDGNKTvrVbcEUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] watchdog: s3c2410: Simplify getting driver data
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Mar 14, 2017 at 3:17 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Monday, March 13, 2017 09:07:25 PM Krzysztof Kozlowski wrote:
>> Simplify the flow in helper function for getting the driver data by
>> using of_device_get_match_data() and only one if() branch.
>>
>> The code should be equivalent.
>
> While you are at it could you remove s3c2410_get_wdt_drv_data()
> helper?  It is used only once during probe and is marked inline
> anyway..

Thanks for feedback!
The existence of this helper is purely from code readability (thus
inline does not matter). The probe is big so splitting some small
self-contained part helps. Not much but a little...

Best regards,
Krzysztof
