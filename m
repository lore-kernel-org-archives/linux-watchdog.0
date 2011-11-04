Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:29944 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1KDSpR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Nov 2011 14:45:17 -0400
Date: Fri, 4 Nov 2011 21:44:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-watchdog@vger.kernel.org
Subject: re: watchdog: Convert wm831x driver to watchdog core
Message-ID: <20111104184458.GA6650@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

Smatch complains about 21cef54c0b1 "watchdog: Convert wm831x driver
to watchdog core"

drivers/watchdog/wm831x_wdt.c +159 wm831x_wdt_set_timeout(17)
	error: buffer overflow 'wm831x_wdt_cfgs' 7 <= 7

   142  static int wm831x_wdt_set_timeout(struct watchdog_device *wdt_dev,
   143                                    unsigned int timeout)
   144  {
   145          struct wm831x_wdt_drvdata *driver_data = watchdog_get_drvdata(wdt_dev);
   146          struct wm831x *wm831x = driver_data->wm831x;
   147          int ret, i;
   148  
   149          for (i = 0; i < ARRAY_SIZE(wm831x_wdt_cfgs); i++)
   150                  if (wm831x_wdt_cfgs[i].time == timeout)
   151                          break;
   152          if (i == ARRAY_SIZE(wm831x_wdt_cfgs))
   153                  ret = -EINVAL;
                        ^^^^^^^^^^^^^^

We overwrite this return value on the next line.  I don't know the
code well enough to say if the intent was to return directly or to
unlock first and then return.

   154  
   155          ret = wm831x_reg_unlock(wm831x);

regards,
dan carpenter
