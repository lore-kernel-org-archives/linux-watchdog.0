Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795342091;
	b=xPhZgDjMLlZMiS9kQF1NENocFBCBNXFUXTDdh7oIFl9zvYRylnuuE4GayBRfjJtjptq9
	 2jWEU3wqU/0jfL5+TaEy9VDf59WImBX6ZpWnmiNVwmJxIas2V/g19tQ20dRXA6yDe5ORU
	 lWi4FNhjJ4fr2w2xwsAidpmMF26bcbX0RGW3mRQkY+WnUMvmTCHEYtFiHer/UcDtJGK7F
	 Y1/U08t2otGYSNoIY/YTZfHku2uHV+qhezT9SInN6vdHZIVguB4mpeWJ5GK71gdkCDiU8
	 PBLWFccOMp2PxMO3GEPdEoIlxgE7Zw2x+HBxCw2IGUDRf0iT+SCY5WRV767dUD8ed6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795342091;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=egF/b0XrxAn1ts7Isj8Iu+j0r+ysO1k1OHUcpzWFCjo=;
	b=xIupj/mC7eH16Xl9YzLPrJK0IoypS1McbVPEjqcpE4MEkwH3SZ9hq61GNuzgslaa3ijJ
	 szfPd+PvFgqV5ywDdtfhISEQYQyGH8buZkRC1YNvg+Pd8boCbM9ArgLN5VCwVZ/fJzpvw
	 qQstnuobpFzp/9gpDSqtWYyuX+wk/7PqHrmba0TOnAirihRUu+NFIjEKIIbm6SFEUQRea
	 yB6jdK8Ulo4SD4WS+Js9A7E18PqYXN96dXYAG6R7/wsb+YaKF70RoBkeQNTX70gqeorrH
	 DF0Ex/TQ9hfdmKsTfj4bewESnK3HBE0uLhltKUjiu+tx3QODqNxA03pU6qnxSRYyTpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=NjlZu8y2;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EDA606A320
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 10:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5EDA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=NjlZu8y2
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id UzgKxpCT7V16IV4UTxh9U4; Sun, 22 Nov 2026 10:08:09 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id V4USxrf5ndRrRV4UTxZ2hf; Sun, 22 Nov 2026 10:08:09 +0000
X-Authority-Analysis: v=2.4 cv=LOhmQIW9 c=1 sm=1 tr=0 ts=6b02bf09
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=PFCYaXOscNU-RV6WzkIA:9 a=CjuIK1q_8ugA:10 a=7RSCp7fvD1wA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=egF/b0XrxAn1ts7Isj8Iu+j0r+ysO1k1OHUcpzWFCjo=; b=NjlZu8y2feg8bE2w8v5NEWYFQx
	xvETgBJi0NT8F8pndiPDvAo1ZG6ucvXK5+Nge+NBmh40YoxlqI6DZ4wy1o0ngvKkP3AK4/PBm3o85
	b6HxdOl8pKd3XMkVxd0sJHJ0hglDYLUHb1Z98qTmtapgKdCYVbkRNffThgjhhoxRi+4XS97D08dVT
	Yb/BUqsBY8ZMBOimoRQk6Pp/igHVnFUbNIPcfEqWi7maNRQWSiswlZHNt5xcnGXn5+Q19P6WO+7Jz
	DbWKa08qtcMdoBYEJoGEg400zQ3iIdhDmiCiJnvA9L5tuZAZiFKzDGyMVhLStu2P5Gxo63PYlm2+R
	jtxHAoJA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36998 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xV4US-00000004BEP-2btM;
	Sun, 22 Nov 2026 15:38:08 +0530
Date: Sun, 22 Nov 2026 02:08:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Artem Novak <artem122novak@gmail.com>
Cc: wim@linux-watchdog.org, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: bcm2835: add newline to dev_info message
Message-ID: <7ec5f7ac-0ede-49e3-8f2e-4ac5a04ec806@roeck-us.net>
References: <20261122082943.173681-1-artem122novak@gmail.com>
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
In-Reply-To: <20261122082943.173681-1-artem122novak@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xV4US-00000004BEP-2btM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:36998
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 13
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCgZRIlb6v0af57+laKA9MxnFwqylNUxOsbX13y7+4F2ZuB3lNuWx0uoNxClNm5udM4Vgjfhoo12K8RkGgv/ThXGx/BsxdH2HvihzACk5ti8i/J56AMr
 Mzc4rXrj2ndZAU45HqD6bQZ8ZF+jxCrUWBEiF+BQf8lFukTfUDC20hXIfbvTvohxJIHD6HXD7kpla/ng20COsGx+konCTya+QsE0Rqis9AXxEWx8RES7J8zb

On Sun, Nov 22, 2026 at 02:29:43AM -0600, Artem Novak wrote:
> Signed-off-by: Artem Novak <artem122novak@gmail.com>

Checkpatch says:

WARNING: Missing commit description - Add an appropriate one

Guenter
