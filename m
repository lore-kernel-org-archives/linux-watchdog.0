Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052744;
	b=UBMUWI6twFqJ1Y5Nguwzz+pqpqMNUm0zOY8CfPAziRSjyrwykJAZs3LRLpOmiJV7fI2O
	 NU4JcgP3FNG6zpUYlk2ZDiTsA/0Ppk9URMweQjhxSqJXPpsyWdJ2gTphcvIQl6qB3EFmD
	 9cxuVzl9e/RN0PoNLGvRZWnLubCfJTLe6KzxCOTTRhxsw+Pzw5C1WAsOfKtDQahOUGAr7
	 bZknfUNXoA6KbmRdXEi47c4nxxqq12EGx6VJ0RYEUoDsgRiExitr2/kgBwxr58pVvIDEy
	 rrkxk2XH6ZbpkTGEH/8btwuazodp1qaAFK0QJvXwTkc5s9nvPVmdRjwVcxiwC3RYW4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052744;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=qyij59D23rRpsqpbbijzYQGBvjbJY80qp035umD4osM=;
	b=3oIvnc74FVR+HqeimdpkxuY/6mniMC9ZpYqQTEyC7qdtO1LNc81LBm6Pb/fqo+L+80Qv
	 VAcYmT/E+juO+HSPsA+8cmN/kFoVKupN3t4L/N8snIVluJiAS+F4NtdC/8najR5SMSkXq
	 TH2bHPUjiK1gTllDyiZwS+6vTHSVm3qeg71Wbd8jahV75/AUZOpp6YsxZDQw4OW4oYNem
	 SJGXFcWZuAcSBmJgIABX2EDYjh2zysb8Kf0yoiEFjjh9QSIEvgKqpqTawjjvgMLHSUyNR
	 BwV9PWhw0OvKv3KzOGYE1b2uCvktYjyxKhjZYpfoQHhyBvvybfQiYE4ZQKjn6+8coUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=tmvF0bUQ;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0D606A321
	for <linux-watchdog@vger.kernel.org>; Mon, 26 Oct 2026 22:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7E0D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=tmvF0bUQ
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id LSjfxxAFgMylkLSvWx4tVE; Mon, 26 Oct 2026 22:12:23 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LSvWxaTDJWuAqLSvWxJyhu; Mon, 26 Oct 2026 22:12:22 +0000
X-Authority-Analysis: v=2.4 cv=IpUecK/g c=1 sm=1 tr=0 ts=6adfd046
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10
 a=bQEBGsHSoSxMFjxss8EA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qyij59D23rRpsqpbbijzYQGBvjbJY80qp035umD4osM=; b=tmvF0bUQNQ3Z1mS+t3lIGd42ok
	H+px1EmKWq1+kgzYMqOA+lg9mWN9jXXhd5I8AvDUY3ZHDcy8rWBi7QqtAt4+vtht4SVyv9MTfuGZm
	i1cY35xYeVbG69DiJ2KZoZWm1KUpI2ty3/W806rH2GV1vvWwLH0sTboqotCGXyxGlRK5fyHRM2kEo
	FRSHFIH7bVV1GecfeMt/kijklXmOYd031uGKiLxqSBGuEicaqVlCDBD2pAHgtVXCHcz1ob0TlpasN
	YYtjCHLf2M08FyO95zi6y3uAcBpaMQ3IZGyafRg/YNqpaOz2t0KRBo3mlKupXx0I7qNeRYE3u268y
	sACZsK2w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56594 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLSvV-00000003u3J-3xfi;
	Tue, 27 Oct 2026 03:42:22 +0530
Date: Mon, 26 Oct 2026 15:12:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Carl Smith <carl.smith@alliedtelesis.co.nz>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: octeon-wdt: Add a panic_on_timeout parameter
Message-ID: <eac15dac-6061-403a-a9e6-5074185a0243@roeck-us.net>
References: <20261023191530.327734-1-carl.smith@alliedtelesis.co.nz>
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
In-Reply-To: <20261023191530.327734-1-carl.smith@alliedtelesis.co.nz>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLSvV-00000003u3J-3xfi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:56594
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 66
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHfA6BiSWFJ2eoniNKdrf1WXm6wA7RsfdZ3iGdQHc/i5Tf07fIk1wdM2WXQEIWHUGUmW5JRYPNDBPdKb1d2Le5hF/b6fIgNP9Kimv7q181YmvT1CgM/9
 Tc+bozN11pCPe2NLXrp3EsEwBzE00+EWMe8qkyhG9LXB8f7PrdRTEVSTirnfF0GjV+EyaW4mYnlc/+zssGvIaivnEW2ajksTGJkNw62fy3b+dUdeH8VmYIqR

On Sat, Oct 24, 2026 at 08:15:30AM +1300, Carl Smith wrote:
> The hardware watchdog period is only a few seconds, so the driver counts
> the heartbeat in software and stops poking the hardware when it expires.
> The resulting reset leaves no record for crash loggers such as mtdoops.
> 
> Add a panic_on_timeout module parameter, off by default like softdog's
> soft_panic, that panics when the heartbeat expires. The panic is logged,
> and the hardware watchdog still resets the board.
> 
> Tested on a CN7130 board with mtdoops.
> 
> Signed-off-by: Carl Smith <carl.smith@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter
