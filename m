Return-path: <panand@redhat.com>
Date: Tue, 3 May 2016 20:08:56 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, timur@codeaurora.org,
	wim@iguana.be, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
Message-ID: <20160503143856.GE13045@dhcppc6.redhat.com>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5728A7C3.4010001@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 03/05/2016:06:29:39 AM, Guenter Roeck wrote:
> On 05/03/2016 01:20 AM, Pratyush Anand wrote:
> >Currently only WOR is used to program both first and second stage which
> >provided very limited range of timeout.
> >
> >This patch uses WCV as well to achieve higher range of timeout. This patch
> >programs max_timeout as 255, but that can be increased further as well.
> >
> >Following testing shows that we can happily achieve 40 second default timeout.
> >
> >  # modprobe sbsa_gwdt action=1
> >  [  131.187562] sbsa-gwdt sbsa-gwdt.0: Initialized with 40s timeout @ 250000000 Hz, action=1.
> >  # cd /sys/class/watchdog/watchdog0/
> >  # cat state
> >  inactive
> >  # cat /dev/watchdog0
> >  cat: /dev/watchdog0: Invalid argument
> >  [  161.710593] watchdog: watchdog0: watchdog did not stop!
> >  # cat state
> >  active
> >  # cat timeout
> >  40
> >  # cat timeleft
> >  38
> >  # cat timeleft
> >  25
> >  # cat /dev/watchdog0
> >  cat: /dev/watchdog0: Invalid argument
> >  [  184.931030] watchdog: watchdog0: watchdog did not stop!
> >  # cat timeleft
> >  37
> >  # cat timeleft
> >  21
> >  ...
> >  ...
> >  # cat timeleft
> >  1
> >
> >panic() is called upon timeout of 40s. See timestamp of last kick (cat) and
> >next panic() message.
> >
> >  [  224.939065] Kernel panic - not syncing: SBSA Watchdog timeout
> >
> >Signed-off-by: Pratyush Anand <panand@redhat.com>
> 
> You could also use the new infrastructure (specify max_hw_heartbeat_ms instead
> of max_timeout), and not depend on the correct implementation of WCV.

Thanks for pointing to max_hw_heartbeat_ms. Just gone through it. Certainly it
would be helpful, and some part of this patch will go away. 

In fact after supporting max_hw_heartbeat_ms, there should be no change for
action=0 functionally. However, we would still need some changes for action=1.

When action=1, isr is called, which calls panic(). Calling panic() will further
trigger a dump saving mechanism, which can cause to execute a secondary kernel.
Now, it might happen that with the limited timeout (max_hw_heartbeat_ms)
programmed in first kernel, we land into a reset before secondary kernel could
start kicking it again or would complete dump save. 
So, in my opinion:
(1) We should use max_hw_heartbeat_ms.
(2) Then we should overwrite WCV in ISR so that it ensures a timeout of user
programmed "timeout" value for hardware reset.

~Pratyush
