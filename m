Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:62364 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab3CXJSD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 24 Mar 2013 05:18:03 -0400
Date: Sat, 23 Mar 2013 21:36:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Subject: BookE watchdog timeout value
Message-ID: <20130324043628.GA26967@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

The initial BookE watchdog timeout value is not specified in seconds,
but in periods relative to the system clock speed. It is also configurable
as configuration parameter, which is kind of unusual.

This makes it difficult to find the actual timeout. One has to set the
configuration parameter to some value and then observe the real system
to determine out the actual timeout. This is not very helpful.

I would like to either change the configuration parameter to seconds,
or drop it entirely and set a default of, say, 60 seconds for Book3E
and to the maximum of 3 seconds for BookE.

Any comments / objections / recommendations ?

Thanks,
Guenter
