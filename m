Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:14304 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbaDYNI1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Apr 2014 09:08:27 -0400
From: "Mingarelli, Thomas" <Thomas.Mingarelli@hp.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Masanari Iida <standby24x7@gmail.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH] doc: watchdog: Add an usage note on hpwdt with hp-asrd
Date: Fri, 25 Apr 2014 13:06:55 +0000
Message-ID: <9774516974AF5F4C8A2C3C69CD3412333C3B8A95@G4W3297.americas.hpqcorp.net>
References: <1398423149-5028-1-git-send-email-standby24x7@gmail.com>
 <535A5CEE.40008@roeck-us.net>
In-Reply-To: <535A5CEE.40008@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Yes I need to review this before it being submitted. Some confusion here.

-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Friday, April 25, 2014 8:03 AM
To: Masanari Iida; wim@iguana.be; linux-watchdog@vger.kernel.org; Mingarelli, Thomas; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: watchdog: Add an usage note on hpwdt with hp-asrd

On 04/25/2014 03:52 AM, Masanari Iida wrote:
> An agent software called hp-asrd from Hewlett Packard updates same iLO 
> watchdog timer as hpwdt does update.
> So they can not be uses simultaneously.
> Add this usage note in hpwdt.txt.
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>   Documentation/watchdog/hpwdt.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/watchdog/hpwdt.txt 
> b/Documentation/watchdog/hpwdt.txt
> index 9488078..719c38d 100644
> --- a/Documentation/watchdog/hpwdt.txt
> +++ b/Documentation/watchdog/hpwdt.txt
> @@ -89,7 +89,8 @@ Last reviewed: 06/02/2009
>
>   	Hypertransport/CSI Error       31h
>
> -
> +hpwdt can not work as expected if hp-asrd is running simultaneously.
> +Because both hpwdt and hp-asrd update same iLO watchdog timer.
>

How about adding a note here explaining that hp-asrd is a user space application from HP (assuming that is what it is) ?

Guenter


