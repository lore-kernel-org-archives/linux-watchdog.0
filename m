Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9A585966
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986759; cv=none; b=N7lnD0vGtzp9y46a+GVGP33zF5mDnrZE8chU4vK4I7ZUtvoDmjUMrFExnLuRYLOWaA46nRMw0UsxiUSEMmCc4MFUSLnnTFpI1H6Ikc0X/h8y0Ydi3jEnFGYRuMED3SsKORzZqay7cWUxCao9umQxOvUoFEYzLZJbo8uSeM0mA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986759; c=relaxed/simple;
	bh=EgZSCh+L2dZNhexxdGTyMKZa85FUePBVH8pPZX8mW+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFUhcPp3IgpN2unt8fpTc4xKUlit2OrpyEE9LhdRLGU4rCOG34jDOH/KwXZ3/HN4zWYkH0VEJMnwggM8+W+R2e3n7mFEZe3VTtVMksdC99c4gkzEbywo4s1QNcM9Yi6berYVOuddiEnDGHHrDU3Och1NiGfHxMA8Rghz8B1PycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6TYGPtP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6TYGPtP"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc149372c14so3321646a12.1
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986742; x=1789591542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qt0NOIhyNLN5/KCcLAm6TLa7xwx0XIh9TdrbTwlVTtE=;
        b=V6TYGPtP7X173cZbWvfgflv88LpDQAHR5DX+jVBFGXjj5rDVNoFSUL0nHOsYmSQ5pO
         zDfK36JmA2Kq3lV1cKWGkQZWbfRQZh3f1W6zyiOxa7dEHij12uzWJTGPRpgLx/wnk8V8
         zpUws/FJAw0iZmLsbmAdsGP7419DPtpHBHZroRi2KU15L2kkC5dYCeKECKgWDkHeLar1
         YycDRFlAEBXulusLFhD9recGKVFM2jAg/AzskXrhEwVbuXa/dUTwyAzDvdueAdHl6jPv
         LHMBKdaEFtvn9TTiUUGqlsDUFkETBA14uxbzDPAI7HpXc5EzcuXMO8PH07DaHfK4RBkQ
         SoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986742; x=1789591542;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qt0NOIhyNLN5/KCcLAm6TLa7xwx0XIh9TdrbTwlVTtE=;
        b=eoogxIBy8zNp89wotKAOQPwMv2Z1ga5ZT7ilSeQfOe9vF0g8e0MEyCHekypblXTTyJ
         2YPDRvyjOCdistwAD3Eo2gNN0oDf5E7c+bMqVfoXV52hi8RYGQRfeSkNzmr5K7OiPYVc
         tqPfJnuOU/egdnH1gfXwOsSgHtnTujK0avuH8A4PIb3erO4DqHCKdVa2qB/0/Qo43fl4
         S+enjvCkDJwv7XqWnVo3AcSwLIEY/tA43lM85a5TsgjjHzGbENvLSQjelbr4yj04A8VR
         ivruqB4kC/DdK+60ZNAqSi2Yq1PsqVoyqZeeHJWQGQmHOIQO4t5CWEXydNh7eLNH4XI+
         9jPw==
X-Forwarded-Encrypted: i=1; AKwUvBwZYBls1o9xfKcXOWXGZW1BgIUwWqFZSy1fjLJ/V5+2+pzSPDWv8i75G//RQ5gb4+wsAsWd8J7JYjSX0DuBjg==@vger.kernel.org
X-Gm-Message-State: AFuF++lJi5GvcGSAlpOyJmqAj0FQscsJ34OqMnMSn53vkC86L5712OFo
	ydpQR7zO+Y1Fv39W/JFHQApqgsfoAyZfY3bbdcexnZY85J2ZuIpFLwj/
X-Gm-Gg: AYBFou2Bn4DmRBOHKus5bmf5kUydgvjUi1Zv8pIzwZRv+sc4dHHsMFuP8lnLiHJUt4Z
	IbJfDcVKDN5QELasy7uYzmyw+iTu9fOplF2z/3fp2WC5npnMT55DLnQyP0x6LPOn7k78b4sgmjE
	ZoipuXo2n58ET+UqynSbtDtx+UPVgulV/UTci9vXXd58whEjLaSChouRaXGXC1ad64b7B4p3ZVf
	ngs1IRXDgV8YCu2yB29ZrQQ2KurssuWW1oT63KTEepiocj4wTWVUelNc5lzKQbrstqZkqvUq461
	Fd4AT2F4PatQyl5fMJb5jvmHhska970yuYekyFuPMXwAfuAokYEAITJBIna7CsXXn/lmwb1XRkw
	msO6ZWDrezuq5vCyZF/xAJ5PjmVfro18flBycR0z0YErz+nPf9RK4ei1b/rxgp7O0/G+l85Jj1z
	CY9lgBy46Gi4XGnyAYUmNPFlMP43LqEY31G+AaBb4HzVg9GXNoZC8ugSfnOh+qJP/dU+i0KkdHu
	zuEcCmnjE66wa/e6kP03h4=
X-Received: by 2002:a17:90b:5826:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39b261b07b6mr57273151a91.10.1788986741452;
        Wed, 09 Sep 2026 13:45:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770a018fsm1431244a91.2.2026.09.09.13.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:45:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 13:45:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: fix typos in comments
Message-ID: <af8dede4-ac67-49aa-8f60-bbd5cea798b6@roeck-us.net>
References: <20260904113744.19872-1-hemanth.selam@gmail.com>
 <20260904113744.19872-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904113744.19872-2-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 05:07:40PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Applied.

Thanks,
Guenter
