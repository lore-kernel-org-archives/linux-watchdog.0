Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <55F2415C.1050803@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1440435683-7343-1-git-send-email-fu.wei@linaro.org>
	<1440435683-7343-6-git-send-email-fu.wei@linaro.org>
	<55F20461.20904@redhat.com>
	<55F2415C.1050803@roeck-us.net>
Date: Tue, 15 Sep 2015 01:11:43 +0800
Message-ID: <CADyBb7tMFc85Nd0+Wm8tq7UxHizkCBe5vLtRQ6NOESCOg892VA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jon Masters <jcm@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>, dyoung@redhat.com, Pratyush Anand <panand@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter, Jon,

On 11 September 2015 at 10:50, Guenter Roeck <linux@roeck-us.net> wrote:
> On 09/10/2015 03:29 PM, Jon Masters wrote:
>>
>> On 08/24/2015 01:01 PM, fu.wei@linaro.org wrote:
>>
>>> +       /*
>>> +        * Get the frequency of system counter from the cp15 interface =
of
>>> ARM
>>> +        * Generic timer. We don't need to check it, because if it
>>> returns "0",
>>> +        * system would panic in very early stage.
>>> +        */
>>> +       gwdt->clk =3D arch_timer_get_cntfrq();
>>
>>
>> Just thinking out loud...
>>
>> What happens later if we virtualize this device within KVM/QEMU/Xen and
>> then live migrate to another system in which the frequency changes?
>>
>
> Thinking about it, this scenario would cause severe trouble. I think cloc=
ks
> (like I would assume pretty much all other hardware parameters / register=
s)
> need to be virtualized and must not change.
>
> Example: clock is set to 100 kHz on original system, and 400 kHz on new
> system. Timeout is set to 30s, and registers are programmed accordingly.
> User space sends heartbeats every 15 seconds.
>
> In this scenario, the watchdog would time out after 30/4 =3D 7.5 seconds
> on the new system, or in other words almost immediately.
>
> This would be even worse if the original system had a clock of, say,
> 10 kHz and the new system would use 400 kHz. This just doesn't work.

I have rechecked the SBSA spec and "Architecture Reference Manual(ARM)",
I think we don't need to worry about "the frequency changes", let me
explain this, but if I misunderstand something, please correct me!

(1) what is the clock source (or reference) of SBSA watchdog timer?
SBSA spec(2.3) has answered this well at page 23:
---------------------------
The Watchdog uses the Generic Timer system count value as the timebase
against which the decision to trigger an interrupt is made.
---------------------------

(2) Can the frequency of the Generic Timer System counter be changed?
At ARMv8 ARM,  D6.1.1 System counter :
---------------------------
The Generic Timer provides a system counter with the following specificatio=
n:
Frequency
Increments at *a fixed frequency*, typically in the range 1-50MHz.
Can support one or more alternative operating modes in which it
increments by larger amounts at a lower frequency, typically for
power-saving.

To support lower-power operating modes, the counter can increment by
larger amounts at a lower frequency. For example, a 10MHz system
counter might either increment either:
=E2=80=A2 By 1 at 10MHz.
=E2=80=A2 By 500 at 20kHz,
when the system lowers the clock frequency, to reduce power consumption.
In this case, the counter must support transitions between
high-frequency, high-precision operation, and lower-frequency,
lower-precision operation, without any impact on the required accuracy
of the counter.
---------------------------
So even the frequency of the Generic Timer System counter be changed
by some reason(typically for power-saving), this won't affect the
timeout(and pretimeout) of watchdog, the actual time will be always
right.

*we were talking about real hardware above. Now we think about virtualizati=
on.*
(3) if the virtual watchdog device in KVM/QEMU/Xen is migrated to
another system in which the frequency changes, will it affect the "dog
feeding procedure"?

I don't think so.
if the frequency changes, the frequency of System counter is changed.
But in ARM system, System counter is a global reference for all clocks
or timers(per-cpu and Memory-mapped).
So if   System counter is getting faster, everything in this  virtual
machine is getting faster, and vice versa.

Now we use the example above
if  clock is set to 100 kHz on original system, and 400 kHz on new system.
Timeout is set to 30s, and registers are programmed accordingly. User
space sends heartbeats every 15 seconds.
In this scenario, On the new system, the watchdog would time out after
30/4 =3D 7.5 seconds.
* User space sends heartbeats every 15/4 =3D 3.25 second now , but NOT
15 seconds.*
If everything goes well,  system will keep running.

Hope I understand the question correctly, please  correct me if I miss
something or said anything wrong.

Great thanks for your feedback!

>
> Guenter
>



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
