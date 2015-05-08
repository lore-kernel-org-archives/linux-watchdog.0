Return-path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <554C15A5.2040300@roeck-us.net>
References: <1431036564-4189-1-git-send-email-dianders@chromium.org>
	<554C15A5.2040300@roeck-us.net>
Date: Thu, 7 May 2015 21:01:09 -0700
Message-ID: <CAD=FV=Uv_PLC5-OBJ1Dw5+z7DeWipqfyE=66hrnnoJSRLdVQVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: dw_wdt: Use a mutex, not a spinlock
From: Doug Anderson <dianders@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jisheng Zhang <jszhang@marvell.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

On Thu, May 7, 2015 at 6:47 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/07/2015 03:09 PM, Doug Anderson wrote:
>>
>> Right now the dw_wdt uses a spinlock to protect dw_wdt_open().  The
>> problem is that while holding the spinlock we call:
>> -> dw_wdt_set_top()
>>     -> dw_wdt_top_in_seconds()
>>        -> clk_get_rate()
>>           -> clk_prepare_lock()
>>              -> mutex_lock()
>>
>> Locking a mutex while holding a spinlock is not allowed and leads to
>> warnings like "BUG: spinlock wrong CPU on CPU#1", among other
>> problems.
>>
>> There's no reason to use a spinlock, so switch to a mutex.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

As Dmitry pointed out in another context, and even better fix is to
just remove the spinlock altogether.  I'll send up v2...

-Doug
