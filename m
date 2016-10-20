Return-path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20161020151738.GP24289@lahna.fi.intel.com>
References: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0ipdO2psmdesoQuw_5uuOSqDh22DK04bEJTi1pW0fL53g@mail.gmail.com> <20161020151738.GP24289@lahna.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Oct 2016 17:48:32 +0200
Message-ID: <CAJZ5v0g8dx=Mivf8=4kUdW9JHh9hru5dob73UOFMQeLb6zaSiQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Oct 20, 2016 at 5:17 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Oct 20, 2016 at 05:05:22PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Oct 20, 2016 at 5:03 PM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>> > It turns out we need to ping the watchdog hardware on resume when we
>> > re-program it. Otherwise this results inadvertent reset to trigger right
>> > after the resume is completed.
>> >
>> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Is there a Fixes: tag missing here?
>
> Oops, right. Sorry about that.
>
> It should be:
>
> Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
>
> (I can resend the patch as well, if needed with the Fixes tag).

No worries, I can pick this up from here.

Thanks,
Rafael
