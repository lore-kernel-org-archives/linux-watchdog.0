Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
Date: Fri, 20 Oct 2017 10:53:46 -0600
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Tom Saeger <tom.saeger@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Jimmy Vance <jimmy.vance@hpe.com>, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] Documentation: fix selftests related file refs
Message-ID: <20171020165346.GA14805@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <cover.1507838726.git.tom.saeger@oracle.com>
 <d4ae0439fc28ad274822f62f46b6230114e3e2da.1507838726.git.tom.saeger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ae0439fc28ad274822f62f46b6230114e3e2da.1507838726.git.tom.saeger@oracle.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Oct 12, 2017 at 03:24:10PM -0500, Tom Saeger wrote:
> Make refs to selftests files valid including:
>   - watchdog-test.c
>   - dnotify_test.c
> 
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> ---
>  Documentation/filesystems/dnotify.txt    | 2 +-
>  Documentation/watchdog/hpwdt.txt         | 2 +-
>  Documentation/watchdog/pcwd-watchdog.txt | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/dnotify.txt b/Documentation/filesystems/dnotify.txt
> index 6baf88f46859..15156883d321 100644
> --- a/Documentation/filesystems/dnotify.txt
> +++ b/Documentation/filesystems/dnotify.txt
> @@ -62,7 +62,7 @@ disabled, fcntl(fd, F_NOTIFY, ...) will return -EINVAL.
>  
>  Example
>  -------
> -See Documentation/filesystems/dnotify_test.c for an example.
> +See tools/testing/selftests/filesystems/dnotify_test.c for an example.
>  
>  NOTE
>  ----
> diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
> index 7a9f635d0258..6d866c537127 100644
> --- a/Documentation/watchdog/hpwdt.txt
> +++ b/Documentation/watchdog/hpwdt.txt
> @@ -15,7 +15,7 @@ Last reviewed: 05/20/2016
>  
>   Watchdog functionality is enabled like any other common watchdog driver. That
>   is, an application needs to be started that kicks off the watchdog timer. A
> - basic application exists in the Documentation/watchdog/src directory called
> + basic application exists in tools/testing/selftests/watchdog/ named
>   watchdog-test.c. Simply compile the C file and kick it off. If the system
>   gets into a bad state and hangs, the HPE ProLiant iLO timer register will
>   not be updated in a timely fashion and a hardware system reset (also known as

Taking over hpwdt for Jimmy Vance.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>


> diff --git a/Documentation/watchdog/pcwd-watchdog.txt b/Documentation/watchdog/pcwd-watchdog.txt
> index 4f68052395c0..b8e60a441a43 100644
> --- a/Documentation/watchdog/pcwd-watchdog.txt
> +++ b/Documentation/watchdog/pcwd-watchdog.txt
> @@ -25,7 +25,7 @@ Last reviewed: 10/05/2007
>  
>   If you want to write a program to be compatible with the PC Watchdog
>   driver, simply use of modify the watchdog test program:
> - Documentation/watchdog/src/watchdog-test.c
> + tools/testing/selftests/watchdog/watchdog-test.c
>  
>  
>   Other IOCTL functions include:
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
