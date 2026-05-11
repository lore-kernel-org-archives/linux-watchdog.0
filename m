Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8D3FD14F
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509468; cv=none; b=YwmME8dZgVvpf5SUkyzUWaicAQARVx7h3sUb2iGRklrGJFSb3vYQ+Or6+gvnr0me0Zekc1AK8QeS3rsKWn5R+4LtkPPrOawCb5Pyd3Hnb/4ywWyfVXrhPLKhj1vxoKJ6y+Tu890mNTiWzLqj93qWd6ALX1FaR5q2jhhsH43Tk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509468; c=relaxed/simple;
	bh=wR0x33SVQ5MnRVA7Na6Rw+N1CJkGug8Uedf1WAspY34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZZS4gzyZzG/574/YdwowPxZCe0FXopm8LQWFzcjY6M7Xt9XBGY8/JmgCinA59XfLo+2vJv15FfVgG0CG2yl6+wPqsC2KAOiklquUDeQ5wVV2/yq+yi/yXwnvgdYq9qcoi9hApj1pAsNtiKzyfMCwttejwtx9Qhmuouru0icJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7TtgZD9; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7TtgZD9"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f0ad52830cso6295562eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778509466; x=1779114266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oyNTa4CCAyWVD8VYRFqrbci8ZzpfoEAZbtMoWKbpvY=;
        b=r7TtgZD90sRxrNbT3tEVJunfEtI8eW8O4A5DlKEyBZxIp8qmcfRQ1o8w7d9bkZr9RV
         LwXWFOTH223zjVRE1AU9VgiL0uFmgrBlJHeeArUIUcY0E2VRU7TMSr5qjGq8q0YeAR/T
         nVna/UiU90sUjPh0Q+YT0lI5snmDaQ+QDH3/OOL/wfI2tmjtkIz8/t8Qrf0QtSXET/Yn
         aDpEE80ri87w8r1mjLH+2STIJzUx4hbFLb2xgpfOHf1rR73OuhocnecQlvHmrOAcRni1
         UAn4PT5XtzNsLkPF/ZLaq8Ah9ihTb3ZUCFdXd53m9EjzV8wAscapIGLrLLXUnTmnRG3s
         kD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509466; x=1779114266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0oyNTa4CCAyWVD8VYRFqrbci8ZzpfoEAZbtMoWKbpvY=;
        b=l+MyMDZjGT3NNlcJpjVzaYSoF5tLr/aVzGTWzoMypuIlkZmVTNZLdEbifn5UI426Rm
         ICf4V5l70HuodrwBoXwyzB4q0sqiEVEFu5oMiwl7oHF3SXp7jtHyKGMygHj9mKv836Zi
         FbekeMZIdW6oIsjep/ftux+eKCkISgcbsBlkqu6CgHZtpM4V1z6A6AkbPTrWZo84Z+8g
         3GwkN9g/AjqAoYhIwebrIh/by/f0/GCQkZwJFaz60Dn1I3tPCxj4rIim/SAl7J0+A9Bk
         SZ4EepoLzbwVZAA9jdTsk1WnuGPCMW6eliURZ8Sa1SC3ghpbuaHKvglIwRUyn9g7oojg
         7uDw==
X-Forwarded-Encrypted: i=1; AFNElJ92i3cgWWc0Txe2CAgn7ihGEYBzmHEnlMTxMahJh5FPLB4Z0l5XuzSLMV43VRC5zadcgqa2qtqiWP6aUa+d7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAsOfFk0AHUKVFyT/vNChIxGH8T9noxY34L1Ul/7ys8POp9UyW
	WX4vBlYk0+xfkDeogEZoAV8WyQU9yNir/fGrrvsIF67xDRYFAlHhUgM+jlXm6w==
X-Gm-Gg: Acq92OEY9U47gRlTJJPTUexq2fMgBsHNgubFpXiDHBHNfidSCkKz8ZbI6Uu5ktSvUV/
	qKaopABYKUZyOrrafqPwqfk3WmJ/fPaH8NuWr1KG5053sprDe+XcQX2+TUA6GWGLqtgb34Xf7Ko
	OpU1vXZwG/n4bEbY5LrkTbGDLAOJ1c3A3WsWf5NfWxULqDbuDlSK3TOWy86Ghf/xmHjxLC3Ipf9
	RJJXAMknvQekv4BqZhVx9DcXz3zR9zki3LGit7zoS5+b++8s+aq0Su7Av+QdYQE1yEXmPww+OZ/
	8AW95C8e2cWUoDDoThUSuKvnpRTixwWUqtYmqa0gWZS/7FdMX4Ub3C86sBNn5Xo6CZY0ODz/XCW
	KgIL62vpSwhPnw+F9Yhw76UUn/5FQrYCIvzD2p6IQvHg6WEXGzLlisP2eDD6ledn5+o5Q2+kG67
	9/IKWiu6ZpDTaEOX/OrNpx+yMWwRchasiqMwQN
X-Received: by 2002:a05:7300:148a:b0:2ed:a64:a457 with SMTP id 5a478bee46e88-2fb4d68fa17mr4796973eec.20.1778509466413;
        Mon, 11 May 2026 07:24:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d429asm13716691eec.12.2026.05.11.07.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:24:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 May 2026 07:24:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mayur Kumar <kmayur809@gmail.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sb_wdog: add missing SPDX license identifier
Message-ID: <4ec2bce9-98d5-4602-8bdc-2326907e2114@roeck-us.net>
References: <20260510191847.50499-1-kmayur809@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510191847.50499-1-kmayur809@gmail.com>

On Mon, May 11, 2026 at 12:48:47AM +0530, Mayur Kumar wrote:
> checkpatch.pl reports the following warning:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 
> Per Documentation/process/license-rules.rst, add the appropriate SPDX
> license identifier to the first line of the C source file using the
> '//' style comment. Default to GPL-2.0-only.
> 
> Signed-off-by: Mayur Kumar <kmayur809@gmail.com>

Applied.

Guenter
