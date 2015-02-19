Return-path: <timo.kokkonen@offcode.fi>
Message-ID: <54E57F4F.5040300@offcode.fi>
Date: Thu, 19 Feb 2015 08:14:39 +0200
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Guenter Roeck <linux@roeck-us.net>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, linux-watchdog@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <54B53160.6060309@roeck-us.net> <cover.1424262664.git.timo.kokkonen@offcode.fi> <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi> <54E49AA5.40008@roeck-us.net> <20150218151713.7a718311@bbrezillon> <54E4A6C4.4070706@roeck-us.net> <20150218160033.GK11529@piout.net> <CAL_JsqLj=bGTWr1aUMRNMjC+xmftMLjUHnGu5M337jNdDDOsZA@mail.gmail.com>
In-Reply-To: <CAL_JsqLj=bGTWr1aUMRNMjC+xmftMLjUHnGu5M337jNdDDOsZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

On 18.02.2015 23:11, Rob Herring wrote:
> On Wed, Feb 18, 2015 at 10:00 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> Hi,
>>
>> On 18/02/2015 at 06:50:44 -0800, Guenter Roeck wrote :
>>>>>>    Optional properties:
>>>>>>    - timeout-sec: Contains the watchdog timeout in seconds.
>>>>>> +- early-timeout-sec: If present, specifies a timeout value in seconds
>>>>>> +  that the driver keeps on ticking the watchdog HW on behalf of user
>>>>>> +  space. Once this timeout expires watchdog is left to expire in
>>>>>> +  timeout-sec seconds. If this propery is set to zero, watchdog is
>>>>>> +  started (or left running) so that a reset occurs in timeout-sec
>>>>>> +  since the watchdog was started.
>>>>>>
>>>>>>    Example:
>>>>>>
>>>>>>    watchdog {
>>>>>>             timeout-sec = <60>;
>>>>>> +   early-timeout-sec = <120>;
>>>>>
>>>>> That is not a generic property as you defined it; if so,
>>>>> it would have to be implemented in the watchdog core code,
>>>>> not in the at91 code. You'll have to document it in the bindings
>>>>> description for at91sam9_wdt.
>>>>
>>>> Then, if this is a controller specific property, it should be defined
>>>> with the 'atmel,' prefix.
>>>> We're kind of looping here: the initial discussion was "is there a need
>>>> for this property to be a generic one ?", and now you're saying no,
>>>> while you previously left the door opened.
>>>>
>>>> Tomi is proposing a generic approach, as you asked him to. I agree that
>>>> parsing the property in core code and making its value part of the
>>>> generic watchdog struct makes sense (that's what I proposed to Tomi a
>>>> few weeks ago).
>>>>
>>> Hmm ... the problem here is that the property description creates the
>>> assumption or expectation that the property is used if defined,
>>> which is not the case.
>>>
>>> I am not sure how to best resolve this. Maybe a comment in the property
>>> description stating that implementation of is device (driver) dependent ?
>>> After all, that is true for the timeout-sec property as well.
>>>
>>
>> I would leave it in the generic file and state that it may not be
>> implemented in the driver. That way, the property is documented for new
>> driver writers.
>
> That is pretty much true of any optional property. Whether implemented
> in the driver or core is an implementation detail that does not belong
> in the binding.
>
> I find this property pretty questionable. Certainly having the kernel
> service a watchdog either enabled at reset, in the bootloader, or by
> the kernel is a useful feature. A timeout for "how long userspace
> watchdog daemon takes to start" does not belong in DT. timeout-sec
> should be the default/initial timeout and long enough for userspace to
> start. Userspace can then change it to a more suitable value.

That would be a good workaround if we had enough time in the watchdog HW 
to wait long enough for the user space to start up. For example in atmel 
HW the maximum is 16 seconds, which may not be enough for the kernel to 
boot up and the user space to start the watchdog daemon.

But even that is not enough as all of the watchdog drivers attempt to 
*disable* the watchdog device before user space opens it. What good is a 
watchdog if it is disabled by the kernel and we got stuck before the 
daemon wakes up and re-enables it? This the problem with all of the 
watchdog drivers right now. There are plenty of products out there that 
can't deal with this kind of limitation. They are all hacking around it 
one way or another. If there is a crash, the watchdog must reset the 
device. I can't think of any other run time way to configure the 
watchdog for this kind of situation than having a device tree property 
for it.

What I am proposing here is a way to solve this without hacking. I was 
told to think also a way to defer starting the watchdog for a given 
timeout so that user space would have more time to wake up, which 
sounded like a good idea. And this obviously needs to be implemented so 
that the watchdog is guaranteed to reset the device should there be a 
crash of any kind that prevents the watchdog daemon from starting up. 
There are a lot of details that need to be taken care of properly and 
therefore watchdog core can't do much about it, which is why I thought 
there is no much point trying to do it in watchdog core.

But never the less I can try to state this in the documentation just to 
make clear what we are trying to solve here.

Thanks for all the good comments!

-Timo
