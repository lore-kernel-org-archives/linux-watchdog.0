Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:40528 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab1DMIPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Apr 2011 04:15:37 -0400
Received: from kpbe18.cbf.corp.google.com (kpbe18.cbf.corp.google.com [172.25.105.82])
	by smtp-out.google.com with ESMTP id p3D8FZ5o007020
	for <linux-watchdog@vger.kernel.org>; Wed, 13 Apr 2011 01:15:36 -0700
Received: from qyj19 (qyj19.prod.google.com [10.241.83.83])
	by kpbe18.cbf.corp.google.com with ESMTP id p3D8FYEV010272
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 13 Apr 2011 01:15:34 -0700
Received: by qyj19 with SMTP id 19so2306870qyj.9
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Apr 2011 01:15:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110413070259.GE4070@infomag.iguana.be>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<20110413070259.GE4070@infomag.iguana.be>
Date: Wed, 13 Apr 2011 01:15:33 -0700
Message-ID: <BANLkTimE4sNw1it8-te9Hk+earOVd6NeUg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Use "request_muxed_region" in it87 watchdog drivers
From: Natarajan Gurumoorthy <natg@google.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wim,
      Old habits die hard. I will get rid of it and ship out a new patch.

Regards
Nat


On Wed, Apr 13, 2011 at 12:03 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Nat,
>
>> +     (void) request_muxed_region(REG, 2, NAME);
>
> Why do we need to typecast this? Can't we just use
> +       request_muxed_region(REG, 2, NAME);
>
> Kind regards,
> Wim.
>
>
>



-- 
Regards
Nat Gurumoorthy AB6SJ
