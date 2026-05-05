Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1836392C32
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986563; cv=none; b=X816amRolWSCx+1p1i4Mt6lP6e8emtuKtLMT1JVqiIyhtp3XQQG52ZxOd7pQjiAdGvAavTXuJUP6XArTTz3dDJnhDmbNWty8/1NqxMVbUCmvuSGq0O6d+gaKkEqln5kKVb61F+raLqpdjXq2JYhE0Secu72O9dRKEJXuwQuWhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986563; c=relaxed/simple;
	bh=h3BC5YMghxOhOhdCiwgnhzBv6w4kP1j8PYmvyHASdqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSB78r+eXGci2FDGNS3KVh/8wWX3shfFRvNMAzj75YOLShB0Uq0e9mfNXwtnrIOD7okSZUJ8uPqQJnMuPKVqApDonx9LiynY0GvM8jAztPItVkQQjg09DVoVN1J+qD9OBDzS2hZJbxEUj87+AmgUls51Kqa10yFYVTKoquSpNNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnbjjc1z; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnbjjc1z"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so6603402eec.1
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986561; x=1778591361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRzOz7rsFwOGoFl5LB+6NCCOsaP7tXP4lDMDYY3QNz8=;
        b=Dnbjjc1z2Jp12Zg30tEqK+3Nu8J6P+EJ8BlznfBpT0Kpd5zJsgh4NKC3jNHQH3uNOz
         Ulhno5nBzQbBtiARaDb2bTjzsnERvFHpOaOXcdfROvxRdwo476anlkTVgRjsV3/eh+cf
         2ohoIscLkkk6Glznq+FeRFH6QfJOwF8Y4o5ADYWRyJVNO9W2i9dbicyF3Iom3YYY0cJy
         NxshQ1U6Vb+ksEEGHpAEtUnaedaX2PVtIi4wWQtIWwtjZT/aqXHYS6xCKz8Jkknttq4M
         GEK0imPafuUN1olFXebdE0atYcKHUOuGUSy7Pg66tMNMcuLvfe3kp5kR+zV3/AVpJv0/
         M/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986561; x=1778591361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vRzOz7rsFwOGoFl5LB+6NCCOsaP7tXP4lDMDYY3QNz8=;
        b=MZ0AYhAWIZaMJpHERXiCfArXziSjS893ZFEpfU/wU9R4uGIZ7MbaYau4/dGQXRIrv4
         PeTyrJFC0BRkHWZwo3y55wWn+9lx1FtlrVcikQUwePssnWpCE4qf83YxQczhCN3nKfW4
         h5cgWBcdXdzqe5zHoK2jGSuknIROs27QthzQK8VZRqqNUD3MJXgN5tSBxQzyloAqvS1v
         Sv3/kwUNuXIgQcsDwHESO/yDS4S0OMk1ktU7w8BIaDpNwQwjZ+k452o8Bqb49nYkfJ4g
         jVMwBQADC7LV+8JtSzGW+rTNbiZE4/eDqUH7i/P7YI71tjSpquuf/3sy7ZS5AJ68Mfmy
         kmXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RwOZx8PapXwaTXCAKb72479fyCgKRTT5MRdQLtQIwRJkZ/erRBNzVKbjoi8S0jwe3h8yip0RTQteW3N9LVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXE574irfq8IolIUqOuRvxlaqgxEa0mMYe08cpfBxFfcN1/q4
	zo3vx7kFhcl9FPV7hyJQu2avXrpuFQeTjazW+fx9sZEWFIc1Z+lKDpxP
X-Gm-Gg: AeBDieuH/8WhErTEKi2CTtRgsSz9UllsGjIhwfXvxwty9hJVo1761LGnZpLEDdUxGU7
	nzyZl8/S9SGvjCUVTMpbsKSdQOSdSUt1u7eHWzyNqZhwjEWiDJMHa1B7c+yBkBcdjbxA06ySIk/
	bcSeWoa5r3zy03+TrJGexLtE0FXkW+W0SLY+1g91CF0K4fteQBOQiDlSUVNExe1KH5PSSqwFLYy
	kmGJ8PK9RxagMXzQ03SyQXNsJmVH0Me0QWwvz3F2xdnOxbdJ2f+abNfyZQsvU3pGGUDYnMcXtQp
	fPZZJSdDK1qSMuuogF+fytf3rbttxiUkVPn7k3gdrN/KGkZ+F0mk+jV8qtEGRnUm0KxN0mj/owM
	kdPpSQhmr3wWr+iKgn4RCYGciiDspzJSuGDognNWRFkZ0viyLGvgADMmhrh2DY7TPPHy6fMf8Zo
	hgKpX9Yg3tt3jlEDdStG1csfrcYIik/+PI5gZgrhwoUKqad98=
X-Received: by 2002:a05:7300:6d06:b0:2c5:50fe:c78f with SMTP id 5a478bee46e88-2f40841d665mr1356830eec.12.1777986560353;
        Tue, 05 May 2026 06:09:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889cf53sm26489351eec.5.2026.05.05.06.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:09:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:09:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philipp Hahn <p.hahn@avm.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Hahn <phahn-oss@avm.de>, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] watchdog: Move `struct` before name
Message-ID: <accb7a0c-3969-499c-8a80-f39cb9573d33@roeck-us.net>
References: <cover.1777972790.git.phahn-oss@avm.de>
 <e66ec58f3b8252b3676cc9fe68818af95123210c.1777972790.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66ec58f3b8252b3676cc9fe68818af95123210c.1777972790.git.phahn-oss@avm.de>

On Tue, May 05, 2026 at 11:26:13AM +0200, Philipp Hahn wrote:
> From: Philipp Hahn <phahn-oss@avm.de>
> 
> Write `struct ` before the structure name as Sphinx otherwise uses the
> following word after it. See
> https://docs.kernel.org/watchdog/watchdog-api.html#environmental-monitoring
> 
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Applied to my watchdog-next branch.

Thanks,
Guenter
