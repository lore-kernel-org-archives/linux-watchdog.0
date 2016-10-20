Return-path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20161020221931.GA929@roeck-us.net>
References: <20161020150336.97791-1-mika.westerberg@linux.intel.com> <20161020221931.GA929@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Oct 2016 00:47:24 +0200
Message-ID: <CAJZ5v0jRdmskuLsL17UZtS8P6=kCpjNj=qwm-ciEKnQ7VAjXcg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Oct 21, 2016 at 12:19 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Oct 20, 2016 at 06:03:36PM +0300, Mika Westerberg wrote:
>> It turns out we need to ping the watchdog hardware on resume when we
>> re-program it. Otherwise this results inadvertent reset to trigger right
>> after the resume is completed.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> [ assuming Rafael is going to pick it up ]

I am, thanks!

Rafael
