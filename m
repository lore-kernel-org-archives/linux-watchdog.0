Return-path: <dan.carpenter@oracle.com>
Date: Tue, 8 Mar 2016 15:10:16 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org
Subject: re: watchdog: Introduce WDOG_HW_RUNNING flag
Message-ID: <20160308121016.GE28684@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter Roeck,

This is a semi-automatic email about new static checker warnings.

The patch e6c71e84e4c0: "watchdog: Introduce WDOG_HW_RUNNING flag" 
from Feb 28, 2016, leads to the following Smatch complaint:

drivers/watchdog/watchdog_dev.c:752 watchdog_release()
	 error: we previously assumed 'wdd' could be null (see line 718)

drivers/watchdog/watchdog_dev.c
   717		wdd = wd_data->wdd;
   718		if (!wdd)
                     ^^^
Old code assume "wdd" can be NULL.

   719			goto done;
   720	
   721		/*
   722		 * We only stop the watchdog if we received the magic character
   723		 * or if WDIOF_MAGICCLOSE is not set. If nowayout was set then
   724		 * watchdog_stop will fail.
   725		 */
   726		if (!test_bit(WDOG_ACTIVE, &wdd->status))
   727			err = 0;
   728		else if (test_and_clear_bit(_WDOG_ALLOW_RELEASE, &wd_data->status) ||
   729			 !(wdd->info->options & WDIOF_MAGICCLOSE))
   730			err = watchdog_stop(wdd);
   731	
   732		/* If the watchdog was not stopped, send a keepalive ping */
   733		if (err < 0) {
   734			pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
   735			watchdog_ping(wdd);
   736		}
   737	
   738		cancel_delayed_work_sync(&wd_data->work);
   739		watchdog_update_worker(wdd);
   740	
   741		/* make sure that /dev/watchdog can be re-opened */
   742		clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
   743	
   744	done:
   745		mutex_unlock(&wd_data->lock);
   746		/*
   747		 * Allow the owner module to be unloaded again unless the watchdog
   748		 * is still running. If the watchdog is still running, it can not
   749		 * be stopped, and its driver must not be unloaded.
   750		 */
   751		if (!watchdog_hw_running(wdd)) {
                                         ^^^
New code dereferences it without checking.

   752			module_put(wdd->ops->owner);
   753			kref_put(&wd_data->kref, watchdog_core_data_release);
   754		}

regards,
dan carpenter
