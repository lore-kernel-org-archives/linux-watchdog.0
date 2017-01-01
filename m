Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40566 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755167AbdAAXxI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 1 Jan 2017 18:53:08 -0500
To: "wim@iguana.be" <wim@iguana.be>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Auto-conversion of watchdog drivers to use devm functions
Message-ID: <8fb3f1a7-1b72-8da3-adcd-11677c455f82@roeck-us.net>
Date: Sun, 1 Jan 2017 15:53:05 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

With heavy support by Julia Lawall, I created a number of coccinelle scripts
to auto-convert watchdog platform drivers to use devm functions. The result
is quite impressive - many drivers won't even need remove functions anymore
after the conversion.

Question is now how to submit the patches. There are 12 rule files affecting
a total of 62 drivers. Should I submit one patch per driver (62 patches),
one patch per rule (12), or one patch per rule file per driver (183) ?

Also, how should I refer to the rules ? The total number of rule lines
is more than 1,000, which seems to be a bit much for the commit log (even
though not all rules apply to all files).

Thanks,
Guenter
