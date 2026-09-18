Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF04EE85B
	for <linux-watchdog@vger.kernel.org>; Fri, 18 Sep 2026 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744426; cv=none; b=Xb4+BNrn3mKub9o6kTL253TizBi8UDKwBZKYyWNsnautTXyfBU/ZeaZD+AMukU5mspmHpK5r2uMkr6BPDJZk9LaoEx8dQ2ShXaL9158CJcgMdj7vccIRao3+m8xSOBeA/dq+WeA1cGVe53GGnXRRLf6mBusqRnCBS1fbmnS94Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744426; c=relaxed/simple;
	bh=L3hJDeFUAP5rkvJ1/WCwL3h3Wqb21Zns8kRsbWr6XZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3BoaW8BY1WKZW1VrDvYFRBD9BoFJtNm5xMeYv+uwMlZkeQQoj0HJOS3+wsYEdZhVH3ETy/oDTSUOu0Jby4qyCsUdGmCIrmbAaJC9I9j2a5Xm5pCMLh/hPINu3Ega9SVjFx7ppK+4brVro9Efo1+a9Wdl4dDEXZeHlcNWUDqjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBtswpwZ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBtswpwZ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24afso695073a91.3
        for <linux-watchdog@vger.kernel.org>; Fri, 18 Sep 2026 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789744424; x=1790349224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W86cY0tWowiWw7DIUFz4jJRwOitE5r+Lq0ZBB/NLi6Q=;
        b=PBtswpwZJqEL42tUDSsCvd395vRFc9ndFb7xWzvFmD9gpp2gd8hSg+mRhFxEUODExT
         oZF1rF/1oBElf244stkzDlvllAgcJzr4SRKKeOEVRaMp+wGB2SnNUJuz0JhIq1F9elW2
         Yd/cIIwEd4hX+dcaETOJe45/uDVekm08Cyzk7v9pRS0dSI0aSGLSI5+PqSsfWWMNgUB1
         v88c7JQaCQjfXu+/ZPzWsmD/8Z7GSlU+iCkOCUuPe31oTC8ivA1r4WbQx51m9os6o3Mk
         h/zYyFaXmtsb/VO3xWi91ogKDACWLqOcbTcvD58pTWdWBf7LYfKRpfTKlE8PCPFJJHSL
         Jm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789744424; x=1790349224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W86cY0tWowiWw7DIUFz4jJRwOitE5r+Lq0ZBB/NLi6Q=;
        b=qqi671TqwzDsIk2hTH2K8+KqbZUm5HnoYTSbipBcJGUUc88/BAqJU4HtLT559npeny
         k7PsXTX8OZ6RvzSI69bB/3U8XyClMpIIKhXWvtyzr+iGSDNzeztYr97zMm0u8q7FK2sX
         fxZIezIZQdiEW0PS9VS1DEEGbOdp5oXM9Vc7NQx2+e7Ayo5QQXn+AZZnd1edC3vqHJIr
         ue5QXYaApcTSj8Cu+3pZrW1bKrm0Mro3heYyrNisb3+IdUugKJRXcGnZUyQ2sc6Y5YcA
         epWFcFgpac9xb3aoMjeJjiiHuRupfTLR01U7d2je57iBpLIyiDtBZ7ypZUtddvllw9/G
         wEVw==
X-Forwarded-Encrypted: i=1; AKwUvBwxoFKj8mDXEilQUc3Ol65fXmpqILt/rsmYP++QtHk8SvNwhRpi0b8aDA/lKcFqM2R3xZmRRfqO/kjN4eymzw==@vger.kernel.org
X-Gm-Message-State: AFuF++kk9cnAnQrd3vHx5olupbUzkQ5S2ri0FxVWQMAtdOU+9vvHKBU7
	KILanqH5uegPDyG/p5BAUJDAgLiBqkzX6mT/gALL3QzLsD5ykNdeCexyxutkviFz
X-Gm-Gg: AYBFou0JM69jx0bmXdAfFPSgVLetgpYhCghfU29enOWKttXPLJcAPnkN1sVDearNJ01
	2bPDppA1KcnDl3VKwP5IStYJXDXyM2R4EVjnw23BUg6x4bOrB76kObZX42W7/Yxt8EZ0UzFXhF7
	d1pHbQs2ycZjsQULoZMcQrfh7mSIoYbtYE1krTnwKuj1m47AquiIgj413tj3Cu3F2KdP7HGtOH7
	TMkTTRu17QnDs1xIe2Yy5WN3KpwhhWEhXEcOr3kNNVuiBHcvMg/4MHPAUJKkm6QHbLoeFG1KKfj
	0Q+b4zHu/ikROhSOyHK0PqPLwjkwmjIZpJ8Aqcv33fvwZ1AqXSS7PNuEFTSih/y1dnzc2QU3GQT
	sbXY0ReTWZkAih4WUxqy6de+aN25SppBcNquZlPRjopjJ956f01fsm83cw7q1/Rgckjd2X0f6MV
	6WfzGWIruNPMDWwNr3PTG7dkMHo4O/CkS3EHf806Tjx9uWCpEW+yhZr6M5AlzH4YEdB7oynJjiy
	3Z2VVoidUgdDqx20ppySOs=
X-Received: by 2002:a17:90b:4c46:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39e54922644mr9263498a91.0.1789744424139;
        Fri, 18 Sep 2026 08:13:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55895112sm1726870a91.3.2026.09.18.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:13:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 18 Sep 2026 08:13:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: use assign_bit() where applicable
Message-ID: <a376bdd4-edcf-4db0-bf6f-fe79ba14a6f7@roeck-us.net>
References: <20260918141915.3023207-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918141915.3023207-1-peng.fan@oss.nxp.com>

On Fri, Sep 18, 2026 at 10:19:14PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied.

Thanks,
Guenter
