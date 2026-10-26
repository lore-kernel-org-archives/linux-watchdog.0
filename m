Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055692;
	b=S0pGKhEOSacyzkG56FOHOh13MBqlcbLGjGxOziip5PgI7cfcs7RhWH0hGs5VonIrO+oq
	 nQuufz5QLcPQ9DceVegBLGoIGQWUpnGXD8BRe7fGYE6664qBi0CgozUGWRdtQH/wqP+C8
	 kgqXEKRF4p/h0DxQSYGmYoPODJFsJoig6VS75YZZAXwdhtWQWAO1tK0cuyrB2TJr3oCqz
	 vll6A4L5YTBZhvufl9z/dphpS/jgTchIvjNOccVoqpRjqhmSLSgNyLtIUk5qfRItbvTRt
	 ReYnEUSg1WbTSXbUhp6X5Ln63gpwxvJIeDQR5ypjr+WIKfTMUKTmO/B3lB5Gl9ev1+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055692;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=zt8lQ3pyBrzAtax8igYb17d+ZOwQEn1FpWIt7R4TXd4=;
	b=lAmzp7Ws9LMHhxt8RWjKSszfSCxsGQKOIfAixn4rifN9xHlI/DOlN0h+vNDlKaSY91ii
	 yOxhANdHSvqhNaF54WonnOmBjEt9kA9klJ+kzaQK1gyR/QvKMIQUQYs11q6pgkWqroIhe
	 bH3hszb4i68UsJEefIv1Q4SzDsCCjutPk6IANJ4A0ToRovadqZL3jC9Y5/EREkON8+Osf
	 GTjywWayQIcr9VvRcmrG+L189hee/z+M7WscnLpijWUfJ1bAUTXxNpvQxjUcUhBS3+etz
	 WHik3TDsk7SlloHklejVUA3o44CjUZOcKogkdbLkIq9UM/AhlW0i6UX7uZz1b2tgdMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=DHFbXVz5;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3E606A31A
	for <linux-watchdog@vger.kernel.org>; Mon, 26 Oct 2026 23:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1B3E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=DHFbXVz5
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id LL9XxUYbTJFmFLTh5xDqSl; Mon, 26 Oct 2026 23:01:31 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LTh4xXwP89VGYLTh4x5BGZ; Mon, 26 Oct 2026 23:01:30 +0000
X-Authority-Analysis: v=2.4 cv=VrYjA/2n c=1 sm=1 tr=0 ts=6adfdbca
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=wIdtkIOOtEIBfA4DHLMA:9 a=CjuIK1q_8ugA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zt8lQ3pyBrzAtax8igYb17d+ZOwQEn1FpWIt7R4TXd4=; b=DHFbXVz5ap6/m0ye4PVYmP2m9l
	jRuCY6sl5St2n2z7VzTjbRxPHgGrYMZO6+Us1ucuwW22ZTVbcvjKlNM+HG7AQc14O3mwbXK74cSwB
	81yWoz9oJUtrdlCtcSuIJ32K2F/LTEHjrn2ljqfqtYmdgo1W0y98DiY6jCoQdXciSDNPNgT4/YsKz
	624TMXzE37h8Ko5pt0hX+hds0BcGId1rUmMjktWxo+mB04Pulew74+3EQJ5L3ijoL1tMukeX8xygO
	vSeU4kb/Rz9GLuy3CQcH71J7sxGC5EViSegdd8SOUhow773lHn/PwTi6PZN4SLWwSUibJH6jL718w
	ZV3Ax7lg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49542 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLTh3-00000004JhT-48S6;
	Tue, 27 Oct 2026 04:31:30 +0530
Date: Mon, 26 Oct 2026 16:01:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: p.zabel@pengutronix.de, Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com, andi.shyti@kernel.org, iav@iav.lv,
	tzungbi@kernel.org, wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] watchdog: dw_wdt: manage reset line during system
 suspend/resume
Message-ID: <4e40ea83-3ba1-4e2d-aa38-31313b367e78@roeck-us.net>
References: <20261024140854.25664-1-a.shimko.dev@gmail.com>
 <20261024140854.25664-3-a.shimko.dev@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024140854.25664-3-a.shimko.dev@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLTh3-00000004JhT-48S6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:49542
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 13
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE3ZDrRL4qGjH6RjcRyQrvUudSKyIhEQCYdAGI7RYjid0UwjpaiqGKAKdvozIMqS9gkxK3Gqbfd8JyJj2KM5bixsC43MueV8DrwlXJZFY0ZsUIAfRrnO
 WcJjAOzOsi6CYmA1jf+v4xxS8Hnk6bOORdcycBSBEQYBVHNpEHv6S+1+z7QqxFg4thpYD7jXFSSAU4OXkSODJmg0lkSEHamQCzm9GRTyAJaokJUf9GLAs+8u

On Sat, Oct 24, 2026 at 05:08:51PM +0300, Artem Shimko wrote:
> The watchdog controller reset line is not currently managed during system
> suspend/resume. This can lead to an inconsistent hardware state when
> resuming from suspend, as the controller may not be properly reinitialized.
> 
> Assert the reset line before disabling clocks during suspend to ensure
> the controller is held in reset while power is gated. During resume,
> deassert the reset after clocks are enabled and before restoring register
> state to guarantee the controller is properly initialized.
> 
> Tested-by: Igor Velkov <iav@iav.lv>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Applied.

Thanks,
Guenter
