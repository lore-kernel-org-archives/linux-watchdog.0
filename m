Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60235 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbbLWAcy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Dec 2015 19:32:54 -0500
Subject: Re: [PATCH 2/5] watchdog: Separate and maintain variables based on
 variable lifetime
To: Tomas Winkler <tomasw@gmail.com>
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
 <1450645503-16661-3-git-send-email-linux@roeck-us.net>
 <20151221172815.GC12696@localhost>
 <CA+i0qc4-DZvFpOEyJBhMzi=HOc-KowNTf8tebTOh5oinav1S8A@mail.gmail.com>
 <5678AA13.8040708@roeck-us.net>
 <CA+i0qc6O9BJaJd-RrZhoTRUkkCohTjZxVccS=NC6JEUKYwvGPQ@mail.gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Pratyush Anand <panand@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5679EBB3.2000707@roeck-us.net>
Date: Tue, 22 Dec 2015 16:32:51 -0800
MIME-Version: 1.0
In-Reply-To: <CA+i0qc6O9BJaJd-RrZhoTRUkkCohTjZxVccS=NC6JEUKYwvGPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/22/2015 02:05 PM, Tomas Winkler wrote:

>
>  > Do you see a situation where holding the lock between calls into the driver
>  > might be a problem ?
>
> I don't think u are holding the lock now in watchdog_unregister when WDOG_UNREGISTERED was dropped.

the lock is held while clearing the pointers:

	mutex_lock(&wd_data->lock);
         wd_data->wdd = NULL;
         wdd->wd_data = NULL;
         mutex_unlock(&wd_data->lock);

Guenter

