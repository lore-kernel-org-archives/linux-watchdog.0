Return-path: <j.uzycki@elproma.com.pl>
Message-ID: <541C122D.10305@elproma.com.pl>
Date: Fri, 19 Sep 2014 13:23:25 +0200
From: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Wim Van Sebroeck <wim@iguana.be>,
 linux-kernel@vger.kernel.org
Subject: timers vs drivers suspend race
References: <541BFB63.3060006@elproma.com.pl>
In-Reply-To: <541BFB63.3060006@elproma.com.pl>
Content-Type: multipart/alternative;
 boundary="------------060300020601080202090109"
List-ID: <linux-watchdog@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060300020601080202090109
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 8bit

Hi.

I have a doubt about suspending of timers.
I found the patch (not included to linux-next):
https://lkml.org/lkml/2014/7/21/493
but it concerns timers only.

I'm adding PM to the watchdog driver (below).
The driver is capable to stop the watchdog.
However I implemented "keep-on" feature to ping
active watchdog if userland doesn't do it.
For the feature I used a timer.
Now, on wdt_suspend() call I don't know
if timers are suspended before the watchdog driver or
there is no guarantee (race): wdt_suspend() calls wdt_stop()
and after timer's callback will ping watchdog and reenable it.

I found also:
https://lkml.org/lkml/2007/10/25/9
Here del_timer_sync() is called and it solves
the problem.
In my case the timer is serviced in watchdog_dev,
not in the specific-driver.
I can add a flag in the specific-driver
to block watchdog's ping before wdt_stop()
or export new function to suspend/resume
watchdog_dev's timer from the specific-driver.

Could you advice is it necessary?

best regards
Janusz


-- Tre쒏 oryginalnej wiadomo쐁i --
Temat: 	Re: watchdog's pm support preffered implementation
Data: 	Fri, 19 Sep 2014 11:46:11 +0200
Nadawca: 	Janusz U퓓cki <j.uzycki@elproma.com.pl>
Adresat: 	Guenter Roeck <linux@roeck-us.net>, 
linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>



W dniu 2014-09-19 05:11, Guenter Roeck pisze:
> On 09/18/2014 03:02 PM, Janusz U퓓cki wrote:
>> Small fix below in the second implementation.
>>
>> best regards
>> Janusz
>>
>> W dniu 2014-09-18 23:40, Janusz U퓓cki pisze:
>>> Hi again,
>>>
>>> This is the second implementation. Which do you prefer?
>>>
> This one

ok

>
>>> Subject: [PATCH] stmp3xxx_rtc_wdt: Add suspend/resume PM support
>>>
>>>
>>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
>>> ---
>>>  drivers/watchdog/stmp3xxx_rtc_wdt.c | 39 +++++++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> index 3546f03..1946277 100644
>>> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
>>> @@ -95,9 +95,48 @@ static int stmp3xxx_wdt_remove(struct
>>> platform_device *pdev)
>>>         return 0;
>>>  }
>>>
>>> +#ifdef CONFIG_PM_SLEEP
>>> +/* There is no conflict with rtc/rtc-stmp3xxx.c parent
>>> + * because modified registers in PM functions are different */
>
> Coding style, and what does this comment mean ? To me it is just
> confusing.

I will move to comment of commit

>
>>> +static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
>>> +{
>>> +       struct watchdog_device *wdd = dev_get_drvdata(dev);
>>
>> drvdata is NULL, too fast,
>> +       struct watchdog_device *wdd = &stmp3xxx_wdd;
>>
>>> +
>>> +       /* Is keep-on/ping timer suspended before?
>>> +        * or additional driver-specific flag must be added
>>> +        *  to block watchdog ping in the timer?
>>> +        * or disable WATCHDOG_KEEP_ON before wdt_stop
>>> +        *  and restore it in resume? */
>
> You'll have to answer those questions.

I guess you don't know if timers are stopped before susnder of other
drivers?

>
>>> +       if (watchdog_active(wdd)) {
>>> +               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
>
> Does this message add any value ?
>
>>> +               return wdt_stop(wdd);
>>> +       }
>>> +       /* should we use pm_runtime like omap_wdt.c does? */
>
> Isn't that what you do here ?

I meant pm_runtime_put/get_sync() etc.
Maybe it is connected to my question above about timers.

>
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
>
> Does the __maybe_unused really apply ?

What do you preffer: __maybe_unused or ifdef CONFIG_PM_SLEEP?
I guess the first one because SIMPLE_DEV_PM_OPS/SET_SYSTEM_SLEEP_PM_OPS
just uses CONFIG_PM_SLEEP.

>
>>> +{
>>> +       struct watchdog_device *wdd = dev_get_drvdata(dev);
>> +       struct watchdog_device *wdd = &stmp3xxx_wdd;
>
> One of those lines needs to go.
Sure, I wanted to fix it on the list in fast way.
I'll use static stmp3xxx_wdd.

>
> Do you have indentation problems ? Do you use space for indentations,
> maybe ?

No, it's probably Thunderbird copy-paste despite text email format.
When I finish fixes I will send patches using git:
1. watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
2. watchdog: boottime protection feature (requires 'keep on')
3. stmp3xxx_rtc_wdt: WATCHDOG_KEEP_ON enabled
4. stmp3xxx_rtc_wdt: Add suspend/resume PM support

>
>>
>>> +
>>> +       if (watchdog_active(wdd)) {
>>> +               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
>
> Does this message add any value ?

It was only for debug. Removed.

>
>>> +               return wdt_start(wdd);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +#endif /* CONFIG_PM_SLEEP */
>>> +
>>> +static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
>>> +               stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
>
> Please align second line with (
ok

>
>>> +
>>>  static struct platform_driver stmp3xxx_wdt_driver = {
>>>         .driver = {
>>>                 .name = "stmp3xxx_rtc_wdt",
>>> +               .owner = THIS_MODULE,
>
> Is this needed ? I have seen the .owner assignment being removed
> in other drivers recently.

I just noticed that some drivers have the assignment and others not.

https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/include/linux/platform_device.h?id=9447057eaff871dd7c63c808de761b8732407169
http://lxr.free-electrons.com/source/include/linux/platform_device.h?v=3.14
"use a macro to avoid include chaining to get THIS_MODULE"

You are right. The direction is to remove this. Removed.

"owner" history from must have to remove (for others):
http://stackoverflow.com/questions/19467150/significance-of-this-module-in-linux-driver
http://lists.linaro.org/pipermail/linaro-kernel/2013-July/005457.html
https://lkml.org/lkml/2014/9/8/1

best regards
Janusz




--------------060300020601080202090109
Content-Type: text/html; charset=windows-1250
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi.<br>
    <br>
    I have a doubt about suspending of timers.<br>
    I found the patch (not included to linux-next):<br>
    <a class="moz-txt-link-freetext" href="https://lkml.org/lkml/2014/7/21/493">https://lkml.org/lkml/2014/7/21/493</a><br>
    but it concerns timers only.<br>
    <br>
    I'm adding PM to the watchdog driver (below).<br>
    The driver is capable to stop the watchdog.<br>
    However I implemented "keep-on" feature to ping<br>
    active watchdog if userland doesn't do it.<br>
    For the feature I used a timer.<br>
    Now, on wdt_suspend() call I don't know<br>
    if timers are suspended before the watchdog driver or<br>
    there is no guarantee (race): wdt_suspend() calls wdt_stop()<br>
    and after timer's callback will ping watchdog and reenable it.<br>
    <br>
    I found also:<br>
    <a class="moz-txt-link-freetext" href="https://lkml.org/lkml/2007/10/25/9">https://lkml.org/lkml/2007/10/25/9</a><br>
    Here del_timer_sync() is called and it solves<br>
    the problem.<br>
    In my case the timer is serviced in watchdog_dev,<br>
    not in the specific-driver.<br>
    I can add a flag in the specific-driver<br>
    to block watchdog's ping before wdt_stop()<br>
    or export new function to suspend/resume<br>
    watchdog_dev's timer from the specific-driver.<br>
    <br>
    Could you advice is it necessary?<br>
    <br>
    best regards<br>
    Janusz<br>
    <div class="moz-forward-container"><br>
      <br>
      -- Tre쒏 oryginalnej wiadomo쐁i --
      <table class="moz-email-headers-table" cellpadding="0"
        cellspacing="0" border="0">
        <tbody>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">Temat: </th>
            <td>Re: watchdog's pm support preffered implementation</td>
          </tr>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">Data: </th>
            <td>Fri, 19 Sep 2014 11:46:11 +0200</td>
          </tr>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">Nadawca:
            </th>
            <td>Janusz U퓓cki <a class="moz-txt-link-rfc2396E" href="mailto:j.uzycki@elproma.com.pl">&lt;j.uzycki@elproma.com.pl&gt;</a></td>
          </tr>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">Adresat:
            </th>
            <td>Guenter Roeck <a class="moz-txt-link-rfc2396E" href="mailto:linux@roeck-us.net">&lt;linux@roeck-us.net&gt;</a>,
              <a class="moz-txt-link-abbreviated" href="mailto:linux-watchdog@vger.kernel.org">linux-watchdog@vger.kernel.org</a>, Wim Van Sebroeck
              <a class="moz-txt-link-rfc2396E" href="mailto:wim@iguana.be">&lt;wim@iguana.be&gt;</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>W dniu 2014-09-19 05:11, Guenter Roeck pisze:
&gt; On 09/18/2014 03:02 PM, Janusz U퓓cki wrote:
&gt;&gt; Small fix below in the second implementation.
&gt;&gt;
&gt;&gt; best regards
&gt;&gt; Janusz
&gt;&gt;
&gt;&gt; W dniu 2014-09-18 23:40, Janusz U퓓cki pisze:
&gt;&gt;&gt; Hi again,
&gt;&gt;&gt;
&gt;&gt;&gt; This is the second implementation. Which do you prefer?
&gt;&gt;&gt;
&gt; This one

ok

&gt;
&gt;&gt;&gt; Subject: [PATCH] stmp3xxx_rtc_wdt: Add suspend/resume PM support
&gt;&gt;&gt;
&gt;&gt;&gt;
&gt;&gt;&gt; Signed-off-by: Janusz Uzycki <a class="moz-txt-link-rfc2396E" href="mailto:j.uzycki@elproma.com.pl">&lt;j.uzycki@elproma.com.pl&gt;</a>
&gt;&gt;&gt; ---
&gt;&gt;&gt;  drivers/watchdog/stmp3xxx_rtc_wdt.c | 39 +++++++++++++++++++++++
&gt;&gt;&gt;  1 file changed, 39 insertions(+)
&gt;&gt;&gt;
&gt;&gt;&gt; diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c 
&gt;&gt;&gt; b/drivers/watchdog/stmp3xxx_rtc_wdt.c
&gt;&gt;&gt; index 3546f03..1946277 100644
&gt;&gt;&gt; --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
&gt;&gt;&gt; +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
&gt;&gt;&gt; @@ -95,9 +95,48 @@ static int stmp3xxx_wdt_remove(struct 
&gt;&gt;&gt; platform_device *pdev)
&gt;&gt;&gt;         return 0;
&gt;&gt;&gt;  }
&gt;&gt;&gt;
&gt;&gt;&gt; +#ifdef CONFIG_PM_SLEEP
&gt;&gt;&gt; +/* There is no conflict with rtc/rtc-stmp3xxx.c parent
&gt;&gt;&gt; + * because modified registers in PM functions are different */
&gt;
&gt; Coding style, and what does this comment mean ? To me it is just 
&gt; confusing.

I will move to comment of commit

&gt;
&gt;&gt;&gt; +static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
&gt;&gt;&gt; +{
&gt;&gt;&gt; +       struct watchdog_device *wdd = dev_get_drvdata(dev);
&gt;&gt;
&gt;&gt; drvdata is NULL, too fast,
&gt;&gt; +       struct watchdog_device *wdd = &amp;stmp3xxx_wdd;
&gt;&gt;
&gt;&gt;&gt; +
&gt;&gt;&gt; +       /* Is keep-on/ping timer suspended before?
&gt;&gt;&gt; +        * or additional driver-specific flag must be added
&gt;&gt;&gt; +        *  to block watchdog ping in the timer?
&gt;&gt;&gt; +        * or disable WATCHDOG_KEEP_ON before wdt_stop
&gt;&gt;&gt; +        *  and restore it in resume? */
&gt;
&gt; You'll have to answer those questions.

I guess you don't know if timers are stopped before susnder of other 
drivers?

&gt;
&gt;&gt;&gt; +       if (watchdog_active(wdd)) {
&gt;&gt;&gt; +               dev_info(wdd-&gt;dev, "%s: wdt was active\n", __func__);
&gt;
&gt; Does this message add any value ?
&gt;
&gt;&gt;&gt; +               return wdt_stop(wdd);
&gt;&gt;&gt; +       }
&gt;&gt;&gt; +       /* should we use pm_runtime like omap_wdt.c does? */
&gt;
&gt; Isn't that what you do here ?

I meant pm_runtime_put/get_sync() etc.
Maybe it is connected to my question above about timers.

&gt;
&gt;&gt;&gt; +
&gt;&gt;&gt; +       return 0;
&gt;&gt;&gt; +}
&gt;&gt;&gt; +
&gt;&gt;&gt; +static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
&gt;
&gt; Does the __maybe_unused really apply ?

What do you preffer: __maybe_unused or ifdef CONFIG_PM_SLEEP?
I guess the first one because SIMPLE_DEV_PM_OPS/SET_SYSTEM_SLEEP_PM_OPS
just uses CONFIG_PM_SLEEP.

&gt;
&gt;&gt;&gt; +{
&gt;&gt;&gt; +       struct watchdog_device *wdd = dev_get_drvdata(dev);
&gt;&gt; +       struct watchdog_device *wdd = &amp;stmp3xxx_wdd;
&gt;
&gt; One of those lines needs to go.
Sure, I wanted to fix it on the list in fast way.
I'll use static stmp3xxx_wdd.

&gt;
&gt; Do you have indentation problems ? Do you use space for indentations, 
&gt; maybe ?

No, it's probably Thunderbird copy-paste despite text email format.
When I finish fixes I will send patches using git:
1. watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
2. watchdog: boottime protection feature (requires 'keep on')
3. stmp3xxx_rtc_wdt: WATCHDOG_KEEP_ON enabled
4. stmp3xxx_rtc_wdt: Add suspend/resume PM support

&gt;
&gt;&gt;
&gt;&gt;&gt; +
&gt;&gt;&gt; +       if (watchdog_active(wdd)) {
&gt;&gt;&gt; +               dev_info(wdd-&gt;dev, "%s: wdt was active\n", __func__);
&gt;
&gt; Does this message add any value ?

It was only for debug. Removed.

&gt;
&gt;&gt;&gt; +               return wdt_start(wdd);
&gt;&gt;&gt; +       }
&gt;&gt;&gt; +
&gt;&gt;&gt; +       return 0;
&gt;&gt;&gt; +}
&gt;&gt;&gt; +#endif /* CONFIG_PM_SLEEP */
&gt;&gt;&gt; +
&gt;&gt;&gt; +static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
&gt;&gt;&gt; +               stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
&gt;
&gt; Please align second line with (
ok

&gt;
&gt;&gt;&gt; +
&gt;&gt;&gt;  static struct platform_driver stmp3xxx_wdt_driver = {
&gt;&gt;&gt;         .driver = {
&gt;&gt;&gt;                 .name = "stmp3xxx_rtc_wdt",
&gt;&gt;&gt; +               .owner = THIS_MODULE,
&gt;
&gt; Is this needed ? I have seen the .owner assignment being removed
&gt; in other drivers recently.

I just noticed that some drivers have the assignment and others not.

<a class="moz-txt-link-freetext" href="https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/include/linux/platform_device.h?id=9447057eaff871dd7c63c808de761b8732407169">https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/include/linux/platform_device.h?id=9447057eaff871dd7c63c808de761b8732407169</a>
<a class="moz-txt-link-freetext" href="http://lxr.free-electrons.com/source/include/linux/platform_device.h?v=3.14">http://lxr.free-electrons.com/source/include/linux/platform_device.h?v=3.14</a>
"use a macro to avoid include chaining to get THIS_MODULE"

You are right. The direction is to remove this. Removed.

"owner" history from must have to remove (for others):
<a class="moz-txt-link-freetext" href="http://stackoverflow.com/questions/19467150/significance-of-this-module-in-linux-driver">http://stackoverflow.com/questions/19467150/significance-of-this-module-in-linux-driver</a>
<a class="moz-txt-link-freetext" href="http://lists.linaro.org/pipermail/linaro-kernel/2013-July/005457.html">http://lists.linaro.org/pipermail/linaro-kernel/2013-July/005457.html</a>
<a class="moz-txt-link-freetext" href="https://lkml.org/lkml/2014/9/8/1">https://lkml.org/lkml/2014/9/8/1</a>

best regards
Janusz
</pre>
      <br>
    </div>
    <br>
  </body>
</html>

--------------060300020601080202090109--
