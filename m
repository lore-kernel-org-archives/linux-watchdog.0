Return-path: <vilhelm.gray@gmail.com>
Subject: Re: [PATCH] watchdog: Add watchdog timer support for the WinSystems
 EBC-C384
To: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be
References: <20160122011112.GA19993@sophia> <56A1A52E.7000106@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Message-ID: <56A39C63.9080905@gmail.com>
Date: Sat, 23 Jan 2016 10:29:39 -0500
MIME-Version: 1.0
In-Reply-To: <56A1A52E.7000106@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On 01/21/2016 10:42 PM, Guenter Roeck wrote:
> This implies that setting the timeout would start the watchdog,
> which is inappropriate (the timeout can be set while the watchdog
> is stopped).
> 
> Also, setting the timeout sets both the resolution _and_ the timeout,
> which is probably unnecessary when starting or pinging the watchdog.

Help me understand the functionality of the watchdog operations briefly  
since I'm relatively new to the interface. Is it proper to say that the  
start callback starts (and in my case also pings) the watchdog based on  
the value of the previously configured timeout member, while the         
set_timeout callback merely sets the timeout member itself to the        
correct value in seconds accordingly to the watchdog timer's resolution?

>> +    const unsigned base = 0x564;
>> +    const unsigned extent = 5;
>> +    const char *const name = dev_name(dev);
> 
> What is the value of those const variables ? Why not just use dev_name() and defines ?
> 
>> +    int err;
>> +
> 
> Is there a means to detect if this is the correct system ? DMI, maybe ?
> Blindly instantiating the driver seems to be a bit risky and should be avoided
> if possible.

Unfortunately, the watchdog timer hardware lacks probing capabilities;    
the documentation for the motherboard indicates that the watchdog timer  
is exposed over an ISA-style I/O-mapped port address. In other words,    
the watchdog timer is non-hotpluggable.                                  
                                                                         
I agree that carrying around the constant values in the private data     
structure is somewhat unnecessary, so I'll give them global scope over   
the file. I'm hesitant to lose the type-safety of C variables; is there  
a reason to prefer preprocessor defines over const-qualified variables?

>> +    err = watchdog_init_timeout(&wdt->wdd, timeout, dev);
>> +    if (err)
>> +        goto err_init_timeout;
> 
> A more tolerant implementation would set the default timeout.

Should I remove the timeout module parameter entirely, and simply        
initialize the watchdog_device timeout member to the default timeout I   
want (e.g. wdt->wdd.timeout = 60)? Would I still need to call            
watchdog_init_timeout in that case?

> Have you considered using module_platform_driver_probe() ?

For some reason, I was under the impression that I must allocate a       
platform_device before calling platform_driver_probe. I'll try           
module_platform_driver_probe since that would indeed be far simpler if   
the platform_device setup code is unnecessary.

> No MODULE_ALIAS ?

Since the watchdog timer hardware is non-hotpluggable, I'm not sure I    
should add a MODULE_ALIAS for autoloading the module.

William Breathitt Gray
