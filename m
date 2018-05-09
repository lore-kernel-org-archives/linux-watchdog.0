Return-Path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
Return-path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
Subject: Re: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
To: Steve Twiss <stwiss.opensource@diasemi.com>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>
Cc: Support Opensource <Support.Opensource@diasemi.com>,
 "fzuuzf@googlemail.com" <fzuuzf@googlemail.com>,
 Guenter Roeck <groeck7@gmail.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <20180509123243.21170-1-m.felsch@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7019417EA41@SW-EX-MBX02.diasemi.com>
From: Marco Felsch <mfe@pengutronix.de>
Message-ID: <bec3deb4-6163-ff1c-d84c-47a413845445@pengutronix.de>
Date: Wed, 9 May 2018 16:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7019417EA41@SW-EX-MBX02.diasemi.com>
Content-Type: multipart/alternative;
 boundary="------------3222DB2AD45B328A7767148C"
Content-Language: en-US
List-ID: <linux-watchdog@vger.kernel.org>

This is a multi-part message in MIME format.
--------------3222DB2AD45B328A7767148C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steve,

On 05/09/2018 03:50 PM, Steve Twiss wrote:
> Hi Marco,
>
> On 09 May 2018 13:33, Marco Felsch wrote:
>
>> To: wim@linux-watchdog.org; linux@roeck-us.net
>> Subject: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
>>
>> The DA9063 watchdog always resets the system when it changes the timeout
>> value after the bootloader (e.g. Barebox) has it already set.
>>
>> To update the timeout value we have to disable the watchdog, clear the
>> watchdog counter value and write the new timeout value to the watchdog.
>> Clearing the counter value is a feature to be on the safe side, 
>> because the
>> data sheet doesn't describe the behaviour of the watchdog counter value
>> after a watchdog disabling-enable-sequence.
>>
>> The patch is based on Philipp Zabel's <p.zabel@pengutronix.de>previous
>> patch but doesn't wait 150us because the DA9063 doesn't need this delay.
> https://www.dialog-semiconductor.com/products/DA9063
>
> Yes, according to the Dialog datasheet DA9063_2v1, there is no 150us 
> minimum
> assert time limit. But ... that doesn't seem correct to me, because 
> the DA9062
> driver and DA9062 datasheet both show a minimum assertion time, like 
> you said.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/watchdog/da9062_wdt.c?h=v4.17-rc3#n67
>
> So let me check with the hardware engineers.

That would be great looking forward to hear from you. I will prepare a 
v3 if it is.

>> +
>>   static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned 
>> int regval)
>>   {
>> +    int ret;
>> +
>> +    /*
>> +     * The watchdog trigger a reboot if a timeout value is already
>> +     * programmed. Because the timeout value combines two functions in
>> +     * one: indicating the counter limit and starting the watchdog. 
>> To be
>> +     * able to set the watchdog a second time (first time was done 
>> by the
>> +     * bootloader) disable the watchdog clear the counter value 
>> manually and
>> +     * set the new timeout value.
>> +     */
>> +    ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
>> +                 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
>> +    if (ret)
>> +        dev_warn(da9063->dev,
>> +             "Failed to disable watchdog before setting new 
>> timeout\n");
>> +
>> +    ret = _da9063_wdt_reset_timer(da9063);
>> +    if (ret)
>> +        dev_warn(da9063->dev, "Failed to reset watchdog counter\n");

BTW. can you ask them if it is necessary to reset the counter value 
register manually or if this is done by disabling the watchdog.

Regards,
Marco

--------------3222DB2AD45B328A7767148C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <tt>Hi Steve,
    </tt><tt><br>
    </tt><tt>
    </tt><tt><br>
    </tt><tt>On 05/09/2018 03:50 PM, Steve Twiss wrote:
    </tt><tt><br>
    </tt>
    <blockquote type="cite" style="color: #000000;"><tt>Hi Marco, </tt><tt><br>
      </tt> <tt><br>
      </tt><tt>On 09 May 2018 13:33, Marco Felsch wrote: </tt><tt><br>
      </tt> <tt><br>
      </tt>
      <blockquote type="cite" style="color: #000000;"><tt>To: </tt><tt><a
            class="moz-txt-link-abbreviated"
            href="mailto:wim@linux-watchdog.org">wim@linux-watchdog.org</a></tt><tt>;
        </tt><tt><a class="moz-txt-link-abbreviated"
            href="mailto:linux@roeck-us.net">linux@roeck-us.net</a></tt><tt>
        </tt><tt><br>
        </tt><tt>Subject: [PATCH v2] watchdog: da9063: Fix
          setting/changing timeout </tt><tt><br>
        </tt> <tt><br>
        </tt><tt>The DA9063 watchdog always resets the system when it
          changes the timeout </tt><tt><br>
        </tt><tt>value after the bootloader (e.g. Barebox) has it
          already set. </tt><tt><br>
        </tt> <tt><br>
        </tt><tt>To update the timeout value we have to disable the
          watchdog, clear the </tt><tt><br>
        </tt><tt>watchdog counter value and write the new timeout value
          to the watchdog. </tt><tt><br>
        </tt><tt>Clearing the counter value is a feature to be on the
          safe side, because the </tt><tt><br>
        </tt><tt>data sheet doesn't describe the behaviour of the
          watchdog counter value </tt><tt><br>
        </tt><tt>after a watchdog disabling-enable-sequence. </tt><tt><br>
        </tt> <tt><br>
        </tt><tt>The patch is based on Philipp Zabel's </tt><tt><a
            class="moz-txt-link-rfc2396E"
            href="mailto:p.zabel@pengutronix.de">&lt;p.zabel@pengutronix.de&gt;</a></tt><tt>
          previous </tt><tt><br>
        </tt><tt>patch but doesn't wait 150us because the DA9063 doesn't
          need this delay. </tt><tt><br>
        </tt></blockquote>
      <tt><a class="moz-txt-link-freetext"
          href="https://www.dialog-semiconductor.com/products/DA9063">https://www.dialog-semiconductor.com/products/DA9063</a></tt><tt>
      </tt><tt><br>
      </tt> <tt><br>
      </tt><tt>Yes, according to the Dialog datasheet DA9063_2v1, there
        is no 150us minimum </tt><tt><br>
      </tt><tt>assert time limit. But ... that doesn't seem correct to
        me, because the DA9062 </tt><tt><br>
      </tt><tt>driver and DA9062 datasheet both show a minimum assertion
        time, like you said. </tt><tt><br>
      </tt> <tt><br>
      </tt><tt><a class="moz-txt-link-freetext"
href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/watchdog/da9062_wdt.c?h=v4.17-rc3#n67">https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/watchdog/da9062_wdt.c?h=v4.17-rc3#n67</a></tt><tt>
      </tt><tt><br>
      </tt> <tt><br>
      </tt><tt>So let me check with the hardware engineers. </tt><tt><br>
      </tt></blockquote>
    <tt>
    </tt><tt><br>
    </tt><tt>That would be great looking forward to hear from you. I
      will prepare a v3 if it is.
    </tt><tt><br>
    </tt><tt>
    </tt><tt><br>
    </tt>
    <blockquote type="cite" style="color: #000000;">
      <blockquote type="cite" style="color: #000000;"><tt>+ </tt><tt><br>
        </tt><tt>  static int _da9063_wdt_set_timeout(struct da9063
          *da9063, unsigned int regval) </tt><tt><br>
        </tt><tt>  { </tt><tt><br>
        </tt><tt>+    int ret; </tt><tt><br>
        </tt><tt>+ </tt><tt><br>
        </tt><tt>+    /* </tt><tt><br>
        </tt><tt>+     * The watchdog trigger a reboot if a timeout
          value is already </tt><tt><br>
        </tt><tt>+     * programmed. Because the timeout value combines
          two functions in </tt><tt><br>
        </tt><tt>+     * one: indicating the counter limit and starting
          the watchdog. To be </tt><tt><br>
        </tt><tt>+     * able to set the watchdog a second time (first
          time was done by the </tt><tt><br>
        </tt><tt>+     * bootloader) disable the watchdog clear the
          counter value manually and </tt><tt><br>
        </tt><tt>+     * set the new timeout value. </tt><tt><br>
        </tt><tt>+     */ </tt><tt><br>
        </tt><tt>+    ret = regmap_update_bits(da9063-&gt;regmap,
          DA9063_REG_CONTROL_D, </tt><tt><br>
        </tt><tt>+                 DA9063_TWDSCALE_MASK,
          DA9063_TWDSCALE_DISABLE); </tt><tt><br>
        </tt><tt>+    if (ret) </tt><tt><br>
        </tt><tt>+        dev_warn(da9063-&gt;dev, </tt><tt><br>
        </tt><tt>+             "Failed to disable watchdog before
          setting new timeout\n"); </tt><tt><br>
        </tt><tt>+ </tt><tt><br>
        </tt><tt>+    ret = _da9063_wdt_reset_timer(da9063); </tt><tt><br>
        </tt><tt>+    if (ret) </tt><tt><br>
        </tt><tt>+        dev_warn(da9063-&gt;dev, "Failed to reset
          watchdog counter\n"); </tt><tt><br>
        </tt></blockquote>
    </blockquote>
    <tt>
    </tt><tt><br>
    </tt><tt>BTW. can you ask them if it is necessary to reset the
      counter value register manually or if this is done by disabling
      the watchdog.
    </tt><tt><br>
    </tt><tt>
    </tt><tt><br>
    </tt><tt>Regards,
    </tt><tt><br>
    </tt><tt>Marco
    </tt>
  </body>
</html>

--------------3222DB2AD45B328A7767148C--
